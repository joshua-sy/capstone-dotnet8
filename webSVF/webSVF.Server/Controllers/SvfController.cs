using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.Threading;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Microsoft.Win32.SafeHandles;
using System.Net;
// using Newtonsoft.Json;
using System.Text;
using WebSVF.Server;

namespace webSVF.Server.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class SvfController : ControllerBase
    {
        private readonly ILogger<SvfController> _logger;

        public SvfController(ILogger<SvfController> logger)
        {
            _logger = logger;
        }

        [HttpPost]
        public async Task<IActionResult> Post([FromBody] RequestBody requestBody)
        {
            await SetCompileOptions(requestBody.CompileOptions);
            await WriteToCFile(requestBody.Input);
            var output = await LaunchScript();
            var dotGraphs = GetDotGraphs();
            var llvm = await GetLLVMFile();
            var result = new WebSVF.Server.SvfResult
            {
                Name = "Resultant Graphs",
                Output = output,
                Graphs = !output.Contains("error") ? dotGraphs : new List<WebSVF.Server.DotGraph>(),
                Llvm = llvm
            };

            return Ok(result);

            //send a post request
            // var request = (HttpWebRequest)WebRequest.Create("http://3.142.95.238/svf");
            // request.Method = "POST";
            // request.ContentType = "application/json";
            // var json = JsonConvert.SerializeObject(requestBody);
            // var data = Encoding.UTF8.GetBytes(json);
            // using (var stream = await request.GetRequestStreamAsync())
            // {
            //     stream.Write(data, 0, data.Length);
            // }
            // var response = (HttpWebResponse)await request.GetResponseAsync();
            // var responseString = new StreamReader(response.GetResponseStream()).ReadToEnd();
            // var result = JsonConvert.DeserializeObject<SvfResult>(responseString);
            // return Ok(result);
            
        }

        private static async Task<string> GetLLVMFile()
        {
            return System.IO.File.ReadAllText("example.ll");
        }

        private static async Task SetCompileOptions(string compileOptions)
        {
            var analyzeBcScript = "clang " + compileOptions + " example.c -o example.ll\n./svf-ex example.ll";
            await System.IO.File.WriteAllTextAsync("analyzeBcFile.sh", analyzeBcScript);
        }

        private async static Task<string> LaunchScript()
        {
            string command = "sh";
            string argss = "analyzeBcFile.sh";
            string verb = " ";

            ProcessStartInfo procInfo = new ProcessStartInfo();
            procInfo.WindowStyle = ProcessWindowStyle.Normal;
            procInfo.UseShellExecute = false;
            procInfo.FileName = command;   // 'sh' for bash 
            procInfo.Arguments = argss;        // The Script name 
            procInfo.Verb = verb;                // ------------
            procInfo.RedirectStandardOutput = true;
            procInfo.RedirectStandardError = true;

            var p = new Process();
            p.StartInfo = procInfo;
            p.Start();
            string output = p.StandardOutput.ReadToEnd();
            string error = p.StandardError.ReadToEnd();
            p.WaitForExit();
            // await WaitForExitAsync(Process.Start(procInfo), new TimeSpan(0, 0, 30));// Start that process.
            return !String.IsNullOrWhiteSpace(error) ? error : output;
        }

        private static Task<bool> WaitForExitAsync(Process process, TimeSpan timeout)
        {
            ManualResetEvent processWaitObject = new ManualResetEvent(false);
            processWaitObject.SafeWaitHandle = new SafeWaitHandle(process.Handle, false);

            TaskCompletionSource<bool> tcs = new TaskCompletionSource<bool>();

            RegisteredWaitHandle registeredProcessWaitHandle = null;
            registeredProcessWaitHandle = ThreadPool.RegisterWaitForSingleObject(
                processWaitObject,
                delegate (object state, bool timedOut)
                {
                    if (!timedOut)
                    {
                        registeredProcessWaitHandle.Unregister(null);
                    }

                    processWaitObject.Dispose();
                    tcs.SetResult(!timedOut);
                },
                null /* state */,
                timeout,
                true /* executeOnlyOnce */);

            return tcs.Task;
        }

        public static async Task WriteToCFile(string input)
        {
            await System.IO.File.WriteAllTextAsync("example.c", input);
        }

        private static List<WebSVF.Server.DotGraph> GetDotGraphs()
        {
            var dotFiles = new List<WebSVF.Server.DotGraph>();
            foreach (string file in Directory.GetFiles(Directory.GetCurrentDirectory(), "*.dot"))
            {
                dotFiles.Add(new WebSVF.Server.DotGraph { Name = file.Substring(file.LastIndexOf('/') + 1), Graph = System.IO.File.ReadAllText(file) });
            }

            return dotFiles;
        }

        public IActionResult Get()
        {
          var response = new { message = "Hello World from the SVF controller :D" };
          return Ok(response);        
        }
        // private static readonly string[] Summaries = new[]
        // {
        //     "Freezing", "Bracing", "Chilly", "Cool", "Mild", "Warm", "Balmy", "Hot", "Sweltering", "Scorching"
        // };

        // public IEnumerable<Object> Get()
        // {
        //     return Enumerable.Range(1, 5).Select(index => new Object
        //     {
        //         message = "hello world",
        //     })
        //     .ToArray();
        // }
    }
}