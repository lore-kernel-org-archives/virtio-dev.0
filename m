Return-Path: <virtio-dev-return-12702-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7F64C77B7D
	for <virtio-dev@archiver.kernel.org>; Mon, 15 May 2023 20:35:41 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id C891E603C7
	for <virtio-dev@archiver.kernel.org>; Mon, 15 May 2023 20:35:35 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C000B9865BD
	for <virtio-dev@archiver.kernel.org>; Mon, 15 May 2023 20:35:35 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id B4A0A986512; Mon, 15 May 2023 20:35:35 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 9902498650F
	for <virtio-dev@lists.oasis-open.org>; Mon, 15 May 2023 20:35:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684182903; x=1686774903;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tcWPw/AqzfMWAsrxbH5zS5ProGwQNAwXS8wKLuENnXY=;
        b=kGU5dEXJpb3iChBxbI0+pUYJbr0jeO86bqC0ew/Tr1SuvAwrIEzwIF9MAvcmGEklU6
         jxn83yvQeP7WqdOYRGo2WD1Rr/AmgCpSfWSlIz2+hQYkjaV2yXoBWCf3/XHDd5SVzd9/
         TEDpWBsQBIQhr3Ha/ZTUmsd9P+y2oKujhuSwjtKe2vrNDqvuNdXmHINRk18W16RGygO0
         2s1Fms3Z5mbDIASoUUcx7DvUl0chy+Df2K1FM9ypv918aRVl23gQ+ThXihH02J8Jp8G2
         48WEypCeNEl7vMCHZCHV+QjruAMi2xCi27vQoYcMH0hPGcXE4lQJvm71HxIFaT/KrbhB
         r4pw==
X-Gm-Message-State: AC+VfDy7sz5/pNCGMqsWE/2BQ0rI6cmeh5+nVDAKPBjXLVMaHCP9Wl6l
	hZzEBmiXCEdAZgVII/OrYLdFXim0EYJPjIoHL8povqaX/Dymo9e5ya8=
X-Google-Smtp-Source: ACHHUZ6kYDUU9mXz0xtzp6bzXZ3i+gkGwOHunF8O240+u1ap2TfkdJMlVWdnpSU5fRhnPsxq6W5kcR/L8oHMlc9bZoQ=
X-Received: by 2002:adf:eec8:0:b0:306:2b0f:5d48 with SMTP id
 a8-20020adfeec8000000b003062b0f5d48mr23338139wrp.26.1684182902491; Mon, 15
 May 2023 13:35:02 -0700 (PDT)
MIME-Version: 1.0
References: <CABmGT5Hv6Jd_F9EoQqVMDo4w5=7wJYmS4wwYDqXK3wov44Tf=w@mail.gmail.com>
In-Reply-To: <CABmGT5Hv6Jd_F9EoQqVMDo4w5=7wJYmS4wwYDqXK3wov44Tf=w@mail.gmail.com>
From: "T.J. Alumbaugh" <talumbau@google.com>
Date: Mon, 15 May 2023 14:34:26 -0600
Message-ID: <CABmGT5GjuhtAiggGvuUEU0OQ+EB01a4Zqm-++c3eU0U7L_-paA@mail.gmail.com>
To: virtio-dev@lists.oasis-open.org, virtio-comment@lists.oasis-open.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [virtio-dev] [RFC PATCH 1/1] virtio-balloon: Add Working Set Reporting feature

Adds VIRTIO_F_WS_REPORTING feature bit.
Adds additional virtqueues and device operation details.

Signed-off-by: T.J. Alumbaugh <talumbau@google.com>
---
 device-types/balloon/description.tex | 228 ++++++++++++++++++++++++++-
 1 file changed, 227 insertions(+), 1 deletion(-)

diff --git a/device-types/balloon/description.tex
b/device-types/balloon/description.tex
index a1d9603..4ea764f 100644
--- a/device-types/balloon/description.tex
+++ b/device-types/balloon/description.tex
@@ -22,6 +22,8 @@ \subsection{Virtqueues}\label{sec:Device Types /
Memory Balloon Device / Virtque
 \item[2] statsq
 \item[3] free_page_vq
 \item[4] reporting_vq
+\item[5] ws_vq
+\item[6] notification_vq
 \end{description}

   statsq only exists if VIRTIO_BALLOON_F_STATS_VQ is set.
@@ -30,6 +32,8 @@ \subsection{Virtqueues}\label{sec:Device Types /
Memory Balloon Device / Virtque

   reporting_vq only exists if VIRTIO_BALLOON_F_PAGE_REPORTING is set.

+  s_vq and notification_vq only exist if VIRTIO_BALLOON_F_WS_REPORTING is =
set.
+
 \subsection{Feature bits}\label{sec:Device Types / Memory Balloon
Device / Feature bits}
 \begin{description}
 \item[VIRTIO_BALLOON_F_MUST_TELL_HOST (0)] Host has to be told before
@@ -48,7 +52,9 @@ \subsection{Feature bits}\label{sec:Device Types /
Memory Balloon Device / Featu
     Configuration field \field{poison_val} is valid.
 \item[ VIRTIO_BALLOON_F_PAGE_REPORTING(5) ] The device has support for fre=
e
     page reporting. A virtqueue for reporting free guest memory is present=
.
-
+\item[ VIRTIO_BALLOON_F_WS_REPORTING(6) ] The device has support for
Working Set
+    (WS) reporting. A virtqueue for reporting WS histograms is
present (ws_vq) and
+    a virtqueue to receive WS-related notifications (notification_vq)
is present.
 \end{description}

 \drivernormative{\subsubsection}{Feature bits}{Device Types / Memory
Balloon Device / Feature bits}
@@ -86,6 +92,8 @@ \subsection{Device configuration
layout}\label{sec:Device Types / Memory Balloon
     read-only by the driver.
   \field{poison_val} is available if VIRTIO_BALLOON_F_PAGE_POISON has been
     negotiated.
+  \field{ws_num_bins} is available if VIRTIO_BALLOON_F_WS_REPORTING has be=
en
+    negotiated.

 \begin{lstlisting}
 struct virtio_balloon_config {
@@ -93,6 +101,7 @@ \subsection{Device configuration
layout}\label{sec:Device Types / Memory Balloon
         le32 actual;
         le32 free_page_hint_cmd_id;
         le32 poison_val;
+        le32 ws_num_bins;
 };
 \end{lstlisting}

@@ -632,3 +641,220 @@ \subsubsection{Free Page
Reporting}\label{sec:Device Types / Memory Balloon Devi
 If the VIRTIO_BALLOON_F_PAGE_POISON feature has been negotiated, the devic=
e
 MUST NOT modify the the content of a reported page to a value other than
 \field{poison_val}.
+
+\subsubsection{Working Set Reporting}\label{sec:Device Types / Memory
Balloon Device / Device Operation / Working Set Reporting}
+
+A Working Set ("WS") measures what memory a computer system has recently
+used (where "recently" is application specific). In most practical systems=
,
+memory is viewed at the granularity of a page. An ideal system would check
+the access time for every page after every instruction, but this is not
+practical. In a realistic scenario, the idle age of a page can be defined =
as:
+
+\begin{lstlisting}
+    idle_age =3D current_system_time - time_access_bit_was_cleared
+\end{lstlisting}
+
+\field{time_access_bit_was_cleared} is a proxy for "time of last access."
+Checking (and clearing) the "accessed" bit on a page table entry is a typi=
cal
+task in operating systems, running from time to time in memory management
+activities. In this scheme, accuracy is sacrificed for improved performanc=
e
+(since less time overall is spent on scanning the memory).
+
+The Working Set consists of "bins" of pages of similar estimated idle age.
+Collecting idle ages for large sets of pages means finding convenient and
+efficient times to check the accessed bits. For all these pages, we associ=
ate
+some time \field{t} with the set, and logically consider them as "accessed
+no later than time t."
+
+The collection of "binned" sets of pages is best described as a histogram,
+where each bin has an associated idle age and all pages in the bin have be=
en
+idle for no longer than that age.
+
+\paragraph{Memory Types: Working Set Reporting}\label{sec:Device
Types / Memory Balloon Device / Device Operation / Working Set
Reporting / Memory Types: Working Set Reporting}
+
+Each bin can describe more than one type of memory, reflecting the differe=
nt
+types of pages tracked by an operating system. Memory types are enumerated
+in the \field{virtio_balloon_ws_memory_type} enum. To guarantee backwards
+compatibility, devices are free to ignore unrecognized WS memory type valu=
es.
+
+\begin{lstlisting}
+enum virtio_balloon_ws_memory_type {
+  VIRTIO_BALLOON_WS_ANON
+ VIRTIO_BALLOON_WS_FILE
+ };
+\end{lstlisting}
+
+The supported memory types are as follows:
+
+\begin{description}
+\item[ANON] Memory that is not backed by files.
+
+\item[FILE] This is memory that is backed by files, and represents the tot=
al
+  of both dirty and clean pages of file-backed memory.
+\end{description}
+
+\paragraph{Idle Age Units}\label{sec:Device Types / Memory Balloon
Device / Device Operation / Working Set Reporting / Idle Age Units}
+
+The time unit for the idle age is specified by the guest system and report=
ed
+by the driver. Valid types are enumerated in the
+\field{virtio_balloon_ws_age_units_type} enum.
+
+\begin{lstlisting}
+enum virtio_balloon_ws_age_units_type {
+  VIRTIO_BALLOON_WS_MILLISECONDS
+ };
+\end{lstlisting}
+
+The currently supported age unit types are:
+
+\begin{description}
+  \item[MILLISECONDS] with a 64-bit unsigned type, this can cover idle age=
s of
+  up to many years.
+\end{description}
+
+\paragraph{NUMA}\label{sec:Device Types / Memory Balloon Device /
Device Operation / Working Set Reporting / NUMA}
+
+A 16 bit node_id is used to communicate the NUMA node associated with a bi=
n of
+the WS report. The node_id MUST be a value between 0 and
+\field{max_numa_nodes} -1 (inclusive). \field{max_numa_nodes} is the maxim=
um
+number of supported NUMA nodes on the guest system.
+
+\paragraph{Working Set Report}\label{sec:Device Types / Memory
Balloon Device / Device Operation / Working Set Reporting / Working
Set Report}
+
+A full WS report is a variable length structure with the following layout:
+
+struct virtio_balloon_ws_report {
+le16 node_id;
+struct {
+le64 idle_age
+le64 memory_size_bytes[2 // nr_types];
+} [ws_num_bins];
+}
+
+Ordering within the report is such that the struct with the smallest
+\field{idle_age} value comes first and  represents the hottest memory, i.e=
. all
+memory in this bin has an idle age of at most `idle_age`, The bin with the=
 next
+largest `idle_age` refers to memory that has an idle_age greater than the =
first
+bin, but less than or equal to the `idle_age` of the current bin, and so o=
n.
+The sequence of struct values MUST be in order of increasing `idle_age`. T=
he
+last struct ALWAYS has an `idle_age` value of  LONG_LONG_MAX, since it
+represents simply the oldest memory with no upper bound on idle age.
+
+The driver MAY send WS Reports at its discretion, typically in times of me=
mory
+pressure. For NUMA systems, a complete report consists of the above array =
for
+one NUMA node. The driver MAY provide a sequence of reports, one for each =
NUMA
+node.
+
+\paragraph{Virtqueue Usage}\label{sec:Device Types / Memory Balloon
Device / Device Operation / Working Set Reporting / Virtqueue Usage}
+
+Notifications are sent from the device to the driver via the notification
+virtqueue. The notification virtqueue is different from other virtqueues i=
n
+that the driver creates an input buffer of the appropriate size and then
+signals the device that the buffer is available. When the device chooses t=
o
+send a notification, it fills the buffer with the appropriate message (and=
 any
+additional data) and notifies the driver. The driver is then responsible f=
or
+reading the notification, taking appropriate action, and then presenting a=
 new
+empty buffer back to the device for the next notification.
+
+Each valid notification has an associated value in the
+\field{virtio_balloon_ws_operation} enum.
+
+\begin{lstlisting}
+enum virtio_balloon_ws_operation_type {
+  VIRTIO_BALLOON_WS_REQUEST 1
+  VIRTIO_BALLOON_WS_CONFIG 2
+ };
+\end{lstlisting}
+
+The first data in the buffer is a 16-bit tag with a valid operation type. =
The
+data that is placed in the buffer after the operation identifier value dep=
ends
+on the operation provided.
+
+The current notification operations are:
+\begin{description}
+\item[WS Request] the device requests that the device send a current WS Re=
port.
+  No additional data is required after this identifier.
+\item[WS Config] This message supplies the required configuration informat=
ion
+  for receiving future WS Reports. After this operation identifier, the
+  following data MUST be in the buffer:
+\end{description}
+
+\begin{lstlisting}
+struct virtio_balloon_ws_config {
+    struct {
+        le64 idle_age
+    } [ws_num_bins - 1];
+    le64 refresh;
+    le64 report;
+    le16 age_units_type;
+}
+\end{lstlisting}
+
+The first \field{ws_num_bins} - 1 values are the interval values provided =
in
+increasing order. They are the expected idle_age values for each bin in th=
e
+reported histogram. Conceptually, the idle_age value represents an upper
+(closed) boundary on the time of last access for all memory associated wit=
h
+that bin (the last bin has no maximum value and simply contains "the colde=
st"
+memory)
+
+The next value is the refresh_threshold. and it indicates an upper bound o=
n
+how old the WS Report may be. It can be useful for the driver to send a
+cached WS Report collected at some point in the recent past, rather than
+collecting the data for a fresh report with each transmission. The time
+referred to via this value indicates how old such a cached report may be. =
Note
+the distinction: "idle age" measures time since the last reference for som=
e
+amount of memory with respect to a moment in time; "staleness" is how far =
in
+the past that instant is allowed to be. The driver MUST NOT send a WS Repo=
rt
+that represents the guest state older than the refresh threshold.
+
+The next value is the report_threshold. It is the rate-limiting mechanism =
that
+indicates a lower bound on the time between reports. After sending a WS Re=
port,
+the driver MUST NOT send another WS Report until report_threshold units of
+time have expired.
+
+The final value is the  virtio_balloon_ws_age_units_type which provides th=
e
+units of the previous {ws_num_bins}+1 values.
+
+The driver MUST NOT begin sending WS reports until it receives an initial
+\field{WS_CONFIG}  message via the notifications virtqueue. The device MAY=
 send
+additional \field{WS_CONFIG} notifications. The number of bins is fixed, b=
ut
+bin intervals, refresh threshold, and report thresholds can be changed.
+
+The allowed range for {ws_num_bins} are set via these values:
+\begin{lstlisting}
+#define VIRTIO_BALLOON_WS_MAX_NUM_BINS  16
+#define VIRTIO_BALLOON_WS_MIN_NUM_BINS  2
+\end{lstlisting}
+
+The ws_vq virtqueue transmits the WS report from the driver to the device.
+This virtqueue functions in a way that is similar to the stats virtqueue.
+The reporting proceeds as follows:
+The driver collects the WS information into a new buffer.
+The driver adds the buffer to the virtqueue and notifies the device.
+The device pops the buffer and consumes the WS report.
+
+The driver determines when to send the WS report, although the device may =
send
+requests for a report (via WS_REQUEST) at any time. The typical situation =
is
+to send the WS report during times of memory pressure, informing the host =
of
+what memory is currently in use, with the notion that the host might trigg=
er
+a balloon deflation.
+
+\drivernormative{\paragraph}{Working Set Reporting}{Device Types /
Memory Balloon Device / Device Operation / Working Set Reporting}
+
+Normative statements in this section apply if the
+VIRTIO_BALLOON_F_WS_REPORTING feature has been negotiated.
+
+The driver MUST NOT report the WS until the WS_CONFIG message is received =
from
+the device.
+The driver MAY report a "cached" WS, that is, a report representing the st=
ate
+of the system at some recent time in the past. The maximum "staleness" of =
the
+WS report is given by the report_threshold, from above.
+
+The driver SHOULD honor the requested idle age units if it is able, but it=
 MAY
+choose other units if the requested units are not supported in the guest. =
In
+that case, the driver MAY supply bin intervals, report and refresh thresho=
lds
+of its choosing. Once the device begins receiving WS reports in the
+non-requested units, it can then follow up with a subsequent WS CONFIG
+specifying desired interval and threshold values in units that the guest s=
ystem
+supports.
+
--=20
2.40.1.606.ga4b1b128d6-goog

On Mon, May 15, 2023 at 2:33=E2=80=AFPM T.J. Alumbaugh <talumbau@google.com=
> wrote:
>
> This is a proposed spec expansion for a Working Set Reporting feature
> in the balloon with driver patch here:
>
> https://lore.kernel.org/linux-mm/20230509185419.1088297-1-yuanchu@google.=
com/
>
> with device implementation here:
>
> https://lists.gnu.org/archive/html/qemu-devel/2023-05/msg02503.html
>
> It describes the requirements for a VIRTIO_F_WS_REPORTING feature bit
> on the balloon device.
>
> Motivation
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> When we have a system with overcommitted memory and 1 or more VMs, we
> seek to get both timely and accurate information on overall memory
> utilization in order to drive appropriate reclaim activities. For
> example, in some client device use cases a VM might need a significant
> fraction of the overall memory for a period of time, but then enter a
> quiet period that results in a large number of cold pages in the guest.
>
> The balloon device has a number of features to assist in sharing memory
> resources amongst the guests and host (e.g free page hinting, stats, free=
 page
> reporting). As mentioned in slide 12 in [1], the balloon doesn't have a g=
ood
> mechanism to drive the reclaim of guest cache. Our use case includes both
> typical page cache as well as "application caches" with memory that shoul=
d be
> discarded in times of system-wide memory pressure.
>
> Working Set Reporting
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Working Set reporting in the balloon provides:
>
>  - an accurate picture of current memory utilization in the guest
>  - event driven reporting (with configurable rate limiting) to deliver re=
ports
>    during times of memory pressure.
>
> The reporting mechanism can be combined with a domain-specific balloon po=
licy
> to drive the separate reclaim activities in a coordinated fashion.
>
> TODOs:
> =3D=3D=3D=3D=3D=3D
>
>  - There are some small differences between this spec and the
>    implementation in the data exchange protocol in the device. We wanted =
to
>    get feedback on this diff at an early stage though, rather than get ev=
ery
>    piece nailed down with precision.
>
> References:
>
> [1] https://kvmforum2020.sched.com/event/eE4U/virtio-balloonpmemmem-manag=
ing-guest-memory-david-hildenbrand-michael-s-tsirkin-red-hat
>
> T.J. Alumbaugh (1):
>   virtio-balloon: Add Working Set Reporting feature
>
>  device-types/balloon/description.tex | 228 ++++++++++++++++++++++++++-
>  1 file changed, 227 insertions(+), 1 deletion(-)
>
> --
> 2.40.1.606.ga4b1b128d6-goog

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

