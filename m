Return-Path: virtio-dev-return-8191-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 273C2986477
	for <virtio-dev@lists.oasis-open.org>; Mon, 14 Jun 2021 23:28:15 +0000 (UTC)
MIME-Version: 1.0
References: <20210614232650.265428-1-chenhaosjtuacm@google.com>
In-Reply-To: <20210614232650.265428-1-chenhaosjtuacm@google.com>
From: Hao Chen <chenhaosjtuacm@google.com>
Date: Mon, 14 Jun 2021 16:28:02 -0700
Message-ID: <CABATKF8CSfNs3VJViX44Ui=ugJriWX680Grm3w6VxtQkE5+LSw@mail.gmail.com>
Subject: [virtio-dev] Fwd: [PATCH v1] Add virtio audio policy device specification
Content-Type: text/plain; charset="UTF-8"
To: virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

---------- Forwarded message ---------
From: Hao Chen <chenhaosjtuacm@google.com>
Date: Mon, Jun 14, 2021 at 4:26 PM
Subject: [PATCH v1] Add virtio audio policy device specification
To: <chenhaosjtuacm@google.com>


This patch includes a new device for coordinating audio among mutliple
VMs.

Signed-off-by: Hao Chen <chenhaosjtuacm@google.com>
---
 conformance.tex         |  18 +++++
 content.tex             |   1 +
 virtio-audio-policy.tex | 171 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 190 insertions(+)
 create mode 100644 virtio-audio-policy.tex

diff --git a/conformance.tex b/conformance.tex
index a164cbb..bca4cf3 100644
--- a/conformance.tex
+++ b/conformance.tex
@@ -31,6 +31,7 @@ \section{Conformance Targets}\label{sec:Conformance
/ Conformance Targets}
 \ref{sec:Conformance / Driver Conformance / Memory Driver Conformance},
 \ref{sec:Conformance / Driver Conformance / I2C Adapter Driver Conformance} or
 \ref{sec:Conformance / Driver Conformance / SCMI Driver Conformance}.
+\ref{sec:Conformance / Driver Conformance / Audio Policy Driver Conformance}.

     \item Clause \ref{sec:Conformance / Legacy Interface:
Transitional Device and Transitional Driver Conformance}.
   \end{itemize}
@@ -54,6 +55,7 @@ \section{Conformance Targets}\label{sec:Conformance
/ Conformance Targets}
 \ref{sec:Conformance / Device Conformance / Memory Device Conformance},
 \ref{sec:Conformance / Device Conformance / I2C Adapter Device Conformance} or
 \ref{sec:Conformance / Device Conformance / SCMI Device Conformance}.
+\ref{sec:Conformance / Device Conformance / Audio Policy Device Conformance}.

     \item Clause \ref{sec:Conformance / Legacy Interface:
Transitional Device and Transitional Driver Conformance}.
   \end{itemize}
@@ -288,6 +290,14 @@ \section{Conformance
Targets}\label{sec:Conformance / Conformance Targets}
 \item \ref{drivernormative:Device Types / SCMI Device / Device
Operation / Setting Up eventq Buffers}
 \end{itemize}

+\conformance{\subsection}{Audio Policy Driver
Conformance}\label{sec:Conformance / Driver Conformance / Audio Policy
Driver Conformance}
+
+An audio policy driver MUST conform to the following normative statements:
+
+\begin{itemize}
+\item \ref{drivernormative:Device Types / Audio Policy / Device Operation}
+\end{itemize}
+
 \conformance{\section}{Device Conformance}\label{sec:Conformance /
Device Conformance}

 A device MUST conform to the following normative statements:
@@ -527,6 +537,14 @@ \section{Conformance
Targets}\label{sec:Conformance / Conformance Targets}
 \item \ref{devicenormative:Device Types / SCMI Device / Device
Operation / Shared Memory Operation}
 \end{itemize}

+\conformance{\subsection}{Audio Policy Device
Conformance}\label{sec:Conformance / Device Conformance / Audio Policy
Device Conformance}
+
+An audio policy device MUST conform to the following normative statements:
+
+\begin{itemize}
+\item \ref{devicenormative:Device Types / Audio Policy / Device Operation}
+\end{itemize}
+
 \conformance{\section}{Legacy Interface: Transitional Device and
Transitional Driver Conformance}\label{sec:Conformance / Legacy
Interface: Transitional Device and Transitional Driver Conformance}
 A conformant implementation MUST be either transitional or
 non-transitional, see \ref{intro:Legacy
diff --git a/content.tex b/content.tex
index 9232d5c..54f9934 100644
--- a/content.tex
+++ b/content.tex
@@ -6568,6 +6568,7 @@ \subsubsection{Legacy Interface: Framing
Requirements}\label{sec:Device
 \input{virtio-mem.tex}
 \input{virtio-i2c.tex}
 \input{virtio-scmi.tex}
+\input{virtio-audio-policy.tex}

 \chapter{Reserved Feature Bits}\label{sec:Reserved Feature Bits}

diff --git a/virtio-audio-policy.tex b/virtio-audio-policy.tex
new file mode 100644
index 0000000..4acca40
--- /dev/null
+++ b/virtio-audio-policy.tex
@@ -0,0 +1,171 @@
+\section{Audio Policy}\label{sec:Device Types / Audio Policy}
+
+When there are multiple guest VMs playing sounds, they may want to cooperate
+with each other. For example, a VM is playing something very critical and want
+to mute everyone else; or it is OK for other to lower the volume ("duck") but
+keep playing; or it is OK to playing concurrently with other sounds. They can
+cooperate via audio policy device. The driver notifies the device when the
+guest VM is playing, and the device will notify other VMs. The driver can also
+suggest the device to mute or duck some audio devices based on the information
+it received from the device.
+
+\subsection{Device ID}\label{sec:Device Types / Audio Policy / Device ID}
+
+39
+
+\subsection{Virtqueues}\label{sec:Device Types / Audio Policy / Virtqueues}
+
+\begin{description}
+\item[0] eventq
+\item[1] requestq
+\item[2] infoq
+\end{description}
+
+\subsection{Feature Bits}\label{sec:Device Types / Audio Policy / Feature Bits}
+
+None currently defined.
+
+\subsection{Device Configuration Layout}\label{sec:Device Types /
Audio Policy / Device Configuration Layout}
+
+None currently defined.
+
+\subsection{Device Initialization}
+
+The driver requests for the known audio device information.
+
+The driver send VIRTIO_AUDIO_POLICY_RESET to the device.
+
+Populate eventq with empty buffers for receiving.
+
+\subsection{Device Operation}\label{sec:Device Types / Audio Policy /
Device Operation}
+
+All requests from the driver go to requestq, with the following format:
+
+\begin{lstlisting}
+enum {
+    VIRTIO_AUDIO_POLICY_AUDIO_DEVICE_INFO = 1,
+    VIRTIO_AUDIO_POLICY_AUDIO_FOCUS_EVENT,
+    VIRTIO_AUDIO_POLICY_VOLUME_CONTROL,
+    VIRTIO_AUDIO_POLICY_FOCUS_INFO,
+    VIRTIO_AUDIO_POLICY_RESET,
+};
+
+struct virtio_audio_policy_hdr {
+    le32 code;
+};
+
+/* Same structure for request and response */
+struct virtio_audio_policy_message {
+    struct virtio_audio_policy_hdr hdr;
+    u8 payload[];
+};
+\end{lstlisting}
+
+\subsubsection{Get Audio Device Information}\label{sec:Device Types /
Audio Policy / Device Operation / Get Audio Device Information}
+
+To get the supported audio device information, the driver sends
+\field{VIRTIO_AUDIO_POLICY_AUDIO_DEVICE_INFO} without payload to the driver.
+The device sends the virtio_audio_policy_message back to the eventq with the
+same header, followed by device information structures:
+
+\begin{lstlisting}
+struct virtio_audio_policy_audio_device_info {
+    char name[128];
+    le32 zone_id;
+};
+\end{lstlisting}
+
+\subsubsection{Audio Focus Updates}\label{sec:Device Types / Audio
Policy / Device Operation / Audio Focus Updates}
+
+When the guest VM is playing sounds, it can inform host and other VMs to
+grab their audio focus by sending requests with header
+\field{VIRTIO_AUDIO_POLICY_AUDIO_FOCUS_EVENT}:
+
+\begin{lstlisting}
+/** The bitwise combination of the virtio_audio_policy_focus_mode flags
+ *  will be stored in \field{mode} in virtio_audio_policy_focus_info
+ */
+enum virtio_audio_policy_focus_mode {
+    /* start playing */
+    VIRTIO_AUDIO_POLICY_M_START = 0x1,
+
+    /* end playing */
+    VIRTIO_AUDIO_POLICY_M_END = 0x2,
+
+    /* transiently grab the focus */
+    VIRTIO_AUDIO_POLICY_M_TRANSIENT = 0x4,
+
+    /* need to play exclusively */
+    VIRTIO_AUDIO_POLICY_M_EXCLUSIVE = 0x8,
+
+    /* allow other sounds to duck */
+    VIRTIO_AUDIO_POLICY_M_ALLOW_DUCK = 0x10,
+}
+
+struct virtio_audio_policy_focus_info {
+    le32 zone_id;
+    le32 audio_usage;
+    le32 mode;
+}
+
+struct virtio_audio_policy_focus_message {
+    struct virtio_audio_policy_hdr hdr;
+    struct virtio_audio_policy_focus_info[];
+};
+\end{lstlisting}
+
+while \field{zone_id} specifies where the sound is played; \field{audio_usage}
+specifies the type of the sound (e.g., music or some high-prioritized emergency
+sounds); \field{mode} is the bit-wise combination of
+virtio_audio_policy_focus_mode. Note that the device will decide
+where the message will be forwarded to. The receiving driver will see it
+in the eventq.
+
+The device may query the drivers for the current focus status of the VM. The
+query will appear on eventq with header VIRTIO_AUDIO_POLICY_FOCUS_INFO. The
+driver should reply in infoq with virtio_audio_policy_focus_message.
+
+\subsubsection{Audio Volume Controls}\label{sec:Device Types / Audio
Policy / Device Operation / Audio Volume Controls}
+
+When the driver decides to mute or duck some of its audio devices, it sends a
+list of audio device names to the device, in the following format:
+
+\begin{lstlisting}
+enum virtio_audio_policy_volume_control {
+    VIRTIO_AUDIO_POLICY_OP_MUTE = 1,
+    VIRTIO_AUDIO_POLICY_OP_DUCK,
+    VIRTIO_AUDIO_POLICY_OP_UNMUTE,
+    VIRTIO_AUDIO_POLICY_OP_UNDUCK,
+}
+
+struct virtio_audio_policy_volume_control_request {
+    struct virtio_audio_policy_hdr hdr;
+    le32 op;
+    char audio_device_names[][128];
+}
+\end{lstlisting}
+
+\subsubsection{Reset}\label{sec:Device Types / Audio Policy / Device
Operation / Reset}
+
+When VIRTIO_AUDIO_POLICY_RESET is sent by the driver, the device must release
+all the focus the driver gained by sending VIRTIO_AUDIO_POLICY_M_END messages
+to other VMs. The device must also unmute and unduck all the devices muted
+and/or ducked by this driver, unless they are also muted or ducked by others.
+When VIRTIO_AUDIO_POLICY_RESET is sent by the device, the driver must end all
+focuses started by the device.
+
+\drivernormative{\subsubsection}{Device Operation}{Device Types /
Audio Policy / Device Operation}
+
+The driver MUST NOT send undefined headers.
+
+The driver MUST NOT put device-readable descriptors into the eventq.
+
+\devicenormative{\subsubsection}{Device Operation}{Device Types /
Audio Policy / Device Operation}
+
+The device MUST send the driver the information of all audio devices
it can mute or duck
+when VIRTIO_AUDIO_POLICY_AUDIO_DEVICE_INFO is received. The device MUST ignore
+the device names requested by the driver if they are not on the list sent to
+the driver.
+
+The device MUST send VIRTIO_AUDIO_POLICY_RESET to the drivers when the device
+recovered from failure.
--
2.32.0.272.g935e593368-goog

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

