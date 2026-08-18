import { Link } from "react-router";
import { FolderKanban, ArrowRight } from "lucide-react";

export default function CloudwatchServerAnomalyPage() {
  return (
    <div className="min-h-[calc(100vh-4rem)] bg-[#080b12] text-white px-6 py-16">
      <div className="max-w-6xl mx-auto">
        <div className="mb-10">
          <h1 className="text-4xl md:text-5xl font-bold tracking-tight mb-3">
            Cloudwatch-server-anomaly
          </h1>
          <p className="text-slate-400 text-lg">
            Public projects page for this repository.
          </p>
        </div>

        <div className="rounded-2xl border border-white/10 bg-[#0d1117] p-6 md:p-8">
          <div className="flex items-center gap-3 mb-4">
            <div className="p-2 rounded-lg bg-[#00d9ff]/10">
              <FolderKanban className="w-5 h-5 text-[#00d9ff]" />
            </div>
            <h2 className="text-2xl font-semibold">Projects</h2>
          </div>
          <p className="text-slate-300 leading-relaxed mb-6">
            CloudWatch server anomaly monitoring and prediction platform with
            live telemetry, ML-based anomaly detection, and dashboard
            operations tooling.
          </p>
          <Link
            to="/"
            className="inline-flex items-center gap-2 px-4 py-2 rounded-lg bg-[#00d9ff]/10 border border-[#00d9ff]/20 text-[#00d9ff] hover:bg-[#00d9ff]/20 transition-colors"
          >
            Back to Home <ArrowRight className="w-4 h-4" />
          </Link>
        </div>
      </div>
    </div>
  );
}
