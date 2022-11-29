Return-Path: <mst@redhat.com>
Date: Tue, 29 Nov 2022 00:34:07 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [virtio-dev] Re: [PATCH v2] virtio_net: support inner header
 hash for GRE-encapsulated packets
Message-ID: <20221129003145-mutt-send-email-mst@kernel.org>
References: <20221122090755.70840-1-hengqi@linux.alibaba.com>
 <CACGkMEsvgqPA4-WxmiYEN=A9ob3a0itNghn3Y62pDMsSyGEEiw@mail.gmail.com>
 <20221128031413.GA118868@h68b04307.sqa.eu95>
 <2cde8c0d-5826-408f-1034-0ed5852310d9@redhat.com>
 <20221128053316.GA103984@h68b04307.sqa.eu95>
 <CACGkMEvCRNFmkNnTaHPcA+=4tDOr7ZdwVHiKwdLTF=_Ad+dmtw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEvCRNFmkNnTaHPcA+=4tDOr7ZdwVHiKwdLTF=_Ad+dmtw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
To: Jason Wang <jasowang@redhat.com>
Cc: Heng Qi <hengqi@linux.alibaba.com>, Yuri Benditovich <yuri.benditovich@daynix.com>, Cornelia Huck <cohuck@redhat.com>, virtio-dev@lists.oasis-open.org, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, Nov 29, 2022 at 11:47:19AM +0800, Jason Wang wrote:
> On Mon, Nov 28, 2022 at 1:33 PM Heng Qi <hengqi@linux.alibaba.com> wrote:
> >
> > On Mon, Nov 28, 2022 at 11:52:23AM +0800, Jason Wang wrote:
> > >
> > > 在 2022/11/28 11:14, Heng Qi 写道:
> > > >On Fri, Nov 25, 2022 at 12:16:05PM +0800, Jason Wang wrote:
> > > >>On Tue, Nov 22, 2022 at 5:08 PM Heng Qi <hengqi@linux.alibaba.com> wrote:
> > > >>>When VIRTIO_NET_F_RSS is negotiated and the tunnel is used to
> > > >>>encapsulate the packets, the hash calculated using the outer header
> > > >>>of the receive packets is always fixed for the same flow packets,
> > > >>>i.e. they will be steered to the same receive queue.
> > > >>>
> > > >>>We add a VIRTIO_NET_HASH_TYPE_GRE_INNER bitmask in \field{hash_types},
> > > >>>which instructs the device to calculate the hash using the inner
> > > >>>headers of GRE-encapsulated packets, and a VIRTIO_NET_HASH_REPORT_GRE
> > > >>>value in \field{hash_tunnel} to report packet type when calculating
> > > >>>hash over the inner header.
> > > >>So I think we need a new feature bit for this to keep migration compatibility.
> > > >>
> > > >If we consider adding feature negotiation for this, it will be explained
> > > >more below.
> > > >
> > > >>>Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
> > > >>>Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > >>>---
> > > >>>v1:
> > > >>>         1. Remove the patch for the bitmask fix. @Michael S. Tsirkin
> > > >>>         2. Clarify some paragraphs. @Jason Wang
> > > >>>         3. Add \field{hash_tunnel} and VIRTIO_NET_HASH_REPORT_GRE. @Yuri Benditovich
> > > >>>
> > > >>>  content.tex | 140 ++++++++++++++++++++++++++++++++++++++++++++++++++--
> > > >>>  1 file changed, 135 insertions(+), 5 deletions(-)
> > > >>>
> > > >>>diff --git a/content.tex b/content.tex
> > > >>>index e863709..fba0c7d 100644
> > > >>>--- a/content.tex
> > > >>>+++ b/content.tex
> > > >>>@@ -3095,7 +3095,7 @@ \subsection{Feature bits}\label{sec:Device Types / Network Device / Feature bits
> > > >>>   to several segments when each of these smaller packets has UDP header.
> > > >>>
> > > >>>  \item[VIRTIO_NET_F_HASH_REPORT(57)] Device can report per-packet hash
> > > >>>-    value and a type of calculated hash.
> > > >>>+    value, a type of calculated hash and a tunnel packet type.
> > > >>>
> > > >>>  \item[VIRTIO_NET_F_GUEST_HDRLEN(59)] Driver can provide the exact \field{hdr_len}
> > > >>>      value. Device benefits from knowing the exact header length.
> > > >>>@@ -3386,7 +3386,8 @@ \subsection{Device Operation}\label{sec:Device Types / Network Device / Device O
> > > >>>          le16 num_buffers;
> > > >>>          le32 hash_value;        (Only if VIRTIO_NET_F_HASH_REPORT negotiated)
> > > >>>          le16 hash_report;       (Only if VIRTIO_NET_F_HASH_REPORT negotiated)
> > > >>>-        le16 padding_reserved;  (Only if VIRTIO_NET_F_HASH_REPORT negotiated)
> > > >>>+        le8 hash_tunnel;        (Only if VIRTIO_NET_F_HASH_REPORT negotiated)
> > > >>It's better not limit this to be tunnel only unless we limit the same
> > > >>for hash_config.
> > > >Maybe we can use the \field{hash_report_ex} instead of \field{hash_tunnel}？
> > >
> > >
> > > Probably.
> > >
> > >
> > > >
> > > >>Btw, this needs an independent fix. I wonder if we need a dedicated
> > > >>feature bit VIRTIO_NET_F_HASH_REPORT_EX and documenting that device
> > > >>SHOULD offer HASH_REPORT_EX along with HASH_REPORT. Then we can do GRE
> > > >>tunnel hash report on top? (Or doing GRE first and fix the mismatch on
> > > >>top)
> > > >>
> > > >For this, we have the following ideas:
> > > >
> > > >1. Considering our actual business application scenarios, the current mainstream
> > > >    tunnel-encapsulated technologies are mainly GRE and VXLAN, so we are also
> > > >    working on VXLAN.
> > > >
> > > >2. To keep migration compatibility, we can add a VIRTIO_NET_F_HASH_GRE_INNER
> > > >    feature bit (it depends on VIRTIO_NET_F_RSS). If it is negotiated, this
> > > >    means that the device calculates the hash based on the inner header of the
> > > >    GRE-encapsulated packet. We assume that the inner header in GRE is TCPv4,
> > > >    at this time \field{hash_types} needs to include
> > > >    (VIRTIO_NET_HASH_TYPE_GRE_INNER | VIRTIO_NET_HASH_TYPE_TCPv4). Besides,
> > > >    if VIRTIO_NET_F_HASH_REPORT is also negotiated, then \field{hash_report}
> > > >    should be set to VIRTIO_NET_HASH_REPORT_TCPv4, and field \field{hash_report_ex}
> > > >    should be set to VIRTIO_NET_HASH_REPORT_GRE.
> > >
> > >
> > > One question here, if I was not wrong, hash_report is sufficient for
> > > GRE and VXLAN now. So that's why I think they should be indenepent
> > > patch.
> > >
> >
> > As discussed in https://lists.oasis-open.org/archives/virtio-dev/202211/msg00064.html,
> > \field{hash_report} is an integer rather than a bitmask.
> 
> Ok, I see.
> 
> > On the premise that
> > VIRTIO_NET_F_HASH_GRE_INNER is negotiated, assuming that the inner header of the GRE packet
> > is TCPv4 and we only have \field{hash_report} instead of \field{hash_report_ex}, then we
> > need to set VIRTIO_NET_HASH_REPORT_GRE(10) in \field{hash_report} along with
> > VIRTIO_NET_HASH_REPORT_TCPv4(2). At this point \field{hash_report} should be (2+10=12).
> >
> > However, if the inner header of another VXLAN packet is IPv4, and VIRTIO_NET_HASH_REPORT_VXLAN
> > is 11 (following VIRTIO_NET_HASH_REPORT_GRE(10), like below), then \field{hash_report} is
> > (1+11=12). Then how does the driver distinguish that 12 belongs to the above which situation?
> >
> > Suppose the report type is as follows:
> > \begin{lstlisting}
> > #define VIRTIO_NET_HASH_REPORT_NONE            0
> > #define VIRTIO_NET_HASH_REPORT_IPv4            1
> > #define VIRTIO_NET_HASH_REPORT_TCPv4           2
> > #define VIRTIO_NET_HASH_REPORT_UDPv4           3
> > #define VIRTIO_NET_HASH_REPORT_IPv6            4
> > #define VIRTIO_NET_HASH_REPORT_TCPv6           5
> > #define VIRTIO_NET_HASH_REPORT_UDPv6           6
> > #define VIRTIO_NET_HASH_REPORT_IPv6_EX         7
> > #define VIRTIO_NET_HASH_REPORT_TCPv6_EX        8
> > #define VIRTIO_NET_HASH_REPORT_UDPv6_EX        9
> > #define VIRTIO_NET_HASH_REPORT_GRE            10
> > #define VIRTIO_NET_HASH_REPORT_VXLAN          11
> > \end{lstlisting}
> >
> > So it seems more reasonable to include tunnel-related report types in \field{hash_report_ex},
> 
> Ok, I think I got this, if we go this way, hash_report_tunnel might be better.

I agree.

> In the long run, the mismatching behaviour of hash_config and
> hash_report might end up more burden in the maintenance. I wonder if
> it's worth it to make hash_report a bitmask that matches hash_config.
> That seems to ease everything a lot.
> 
> Thanks

Maybe but I don't like making this work being blocked by this new idea -
that's reworking this feature quite a lot.
Do you have the time to work on this idea short term?

-- 
MST

