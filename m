Return-Path: <virtio-dev-return-14167-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91B7AC41535
	for <virtio-dev@archiver.kernel.org>; Tue, 19 Dec 2023 07:53:42 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id D61F13357C
	for <virtio-dev@archiver.kernel.org>; Tue, 19 Dec 2023 07:53:41 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C70D2986542
	for <virtio-dev@archiver.kernel.org>; Tue, 19 Dec 2023 07:53:41 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id BA330983F76; Tue, 19 Dec 2023 07:53:41 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A21B6986546
	for <virtio-dev@lists.oasis-open.org>; Tue, 19 Dec 2023 07:53:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: eGH4JNWyNW2mzPkkxzIf1A-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702972407; x=1703577207;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jsheti5U2Gvl+XLTtBMSaxNyjxx+tRZTIrixh0GNXBs=;
        b=bm6iichGcmVjDlJgfW54dyOnnLrGraTIHVBRBcIjVTTql9z094emtUyE89rMBEmY6D
         ENhx7cUXrC+SN3ZFLjCkmDuI3LYSU47QbtLtYK4NOvmckRtwb1s3b2E90H/42ZRM/Hz4
         6eyi30JdGTjpYzzS/L5mwwDwj7tP6f5jAOJh4r6LsQmayPRikfSTgzZEnHLpa+CY+x8t
         LeDdyVqMQ0xwAWmmERZiqNWt0EC0cFoDn1xFKMIrvCzBmW4mdk8YTh4xNf1uHJqEHI9a
         Cc+vRbaa101B2O128+J29XylemM4zwafsGL4y/yFuo3goClXKtdRWSuWk7Vxs7SrK27o
         QpTA==
X-Gm-Message-State: AOJu0Yw35pje7AubUOAbT6M6f7VVz5fBmHd7p3PoMDbF8i+UW+o0U4lS
	BCOP1r8uQNqPxaEv0g1+jdmtvuBANc6FocEI6aMjK787xs3lA6u1heRvyBKYo9HO1VS6p2et3Px
	mCuQyfdffj4M+xEtXH9rzfwsNjXtAC8FiSIIu7YJ4tfJ+
X-Received: by 2002:a05:6a00:2e10:b0:6d0:9913:3363 with SMTP id fc16-20020a056a002e1000b006d099133363mr17135037pfb.46.1702972406551;
        Mon, 18 Dec 2023 23:53:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEyol0Uu8coHqQy+swfORXAUpRtos/BRcN0LQbgaRsGPq1stwqOonA9lE4adyRRQg+irRuZBtAnSy2OV2i+m9Y=
X-Received: by 2002:a05:6a00:2e10:b0:6d0:9913:3363 with SMTP id
 fc16-20020a056a002e1000b006d099133363mr17135021pfb.46.1702972405800; Mon, 18
 Dec 2023 23:53:25 -0800 (PST)
MIME-Version: 1.0
References: <959e1a7ccdfffaaadd865a627924cf492ce22bfa.1702277523.git.hengqi@linux.alibaba.com>
 <20231211110350-mutt-send-email-mst@kernel.org> <a8ba676e-de43-45ae-a6a8-a67d0dd41c1f@linux.alibaba.com>
 <20231212032713-mutt-send-email-mst@kernel.org> <bfd25f86-4292-45d2-a7a2-fe61bde0edb4@linux.alibaba.com>
 <b739d275-3664-4509-8a91-f19690719475@linux.alibaba.com> <fafa078b-14f5-460d-b03e-122afb9156ba@linux.alibaba.com>
 <CACGkMEuCb13=-b1yMYi3NOehL+6eNWjWsmBHfcYho1w0HwpVBA@mail.gmail.com> <6d9353f7-2899-4ba9-8aef-2431c9362207@linux.alibaba.com>
In-Reply-To: <6d9353f7-2899-4ba9-8aef-2431c9362207@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 19 Dec 2023 15:53:14 +0800
Message-ID: <CACGkMEsh9h_syGag48DL9rSSH2Yp4Ht-ES4gA-5rv16Lih_tJw@mail.gmail.com>
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, 
	Yuri Benditovich <yuri.benditovich@daynix.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [virtio-dev] Re: [virtio-comment] Re: [PATCH v5] virtio-net: device does not
 deliver partially checksummed packet and may validate the checksum

On Mon, Dec 18, 2023 at 12:54=E2=80=AFPM Heng Qi <hengqi@linux.alibaba.com>=
 wrote:
>
>
>
> =E5=9C=A8 2023/12/18 =E4=B8=8A=E5=8D=8811:10, Jason Wang =E5=86=99=E9=81=
=93:
> > On Fri, Dec 15, 2023 at 5:51=E2=80=AFPM Heng Qi <hengqi@linux.alibaba.c=
om> wrote:
> >> Hi all!
> >>
> >> I would like to ask if anyone has any comments on this version, if so
> >> please let me know!
> >> If not, I will collect Michael's comments and publish a new version ne=
xt
> >> Monday.
> > I have a dumb question. (And sorry if I asked it before)
> >
> > Looking at the spec and code. It looks to me DATA_VALID could be set
> > without GUEST_CSUM.
>
> I don't see that in the spec.
> Am I missing something? [1][2]
>
> [1] If the VIRTIO_NET_F_GUEST_CSUM feature was negotiated, the
> VIRTIO_NET_HDR_F_DATA_VALID bit in flags can be set: if so, device has
> validated the packet checksum. In case of multiple encapsulated
> protocols, one level of checksums has been validated.
> Additionally, VIRTIO_NET_F_GUEST_CSUM, TSO4, TSO6, UDP and ECN features
> *enable receive checksum*, large receive offload and ECN support which
> are the input equivalents of the transmit checksum, transmit
> segmentation *offloading* and ECN features, as described in 5.1.6.2.
>
> [2] If VIRTIO_NET_F_GUEST_CSUM is not negotiated, the device *MUST set
> flags to zero* and SHOULD supply a fully checksummed packet to the driver=
.

So this is kind of ambiguous and seems not what I wanted when I wrote
the code for DATA_VALID in 2011.

NEEDS_CSUM maps to CHECKSUM_PARTIAL which means the packet checksum is
correct. So spec had

"""
If neither VIRTIO_NET_HDR_F_NEEDS_CSUM nor VIRTIO_NET_HDR_F_DATA_VALID
is set, the driver MUST NOT rely on the packet checksum being correct.
"""

For DATA_VALID, it maps to CHECKSUM_UNNECESSARY which is mutually
exclusive with CHECKSUM_PARTAIL. And this is what Linux did right now:

For tun_put_user():

        if (skb->ip_summed =3D=3D CHECKSUM_PARTIAL) {
                ...
        } else if (has_data_valid &&
                   skb->ip_summed =3D=3D CHECKSUM_UNNECESSARY) {
                   hdr->flags =3D VIRTIO_NET_HDR_F_DATA_VALID;
        } /* else everything is zero */

This CHECKSUM_UNNECESSARY will work even if GUEST_CSUM is disabled if
I was not wrong.

And in receive_buf():

        if (hdr->hdr.flags & VIRTIO_NET_HDR_F_DATA_VALID)
                skb->ip_summed =3D CHECKSUM_UNNECESSARY;

I think we can fix this by safely removing "*MUST set flags to zero*"
in [2] from the spec.

Thanks


>
> I think the reason why the feature bit is not checked in the code is
> because the check is omitted because it is on a per-packet basis,
> just like the reason why supported_valid_types is not needed as
> discussed in the v4 version threads. It is not unnecessary.
>
> Thanks!
>
> >
> > If yes, why do we need to bother here? If we disable GUEST_CSUM, the
> > packet will contain checksum. And if the device sets DATA_VALID, it
> > means the checksum is validated.
> >
> > Thanks
> >
> >
> >
> >> Since Christmas is coming, I think this feature may be in danger of
> >> following the pace of
> >> our hw version releases, so I sincerely request that you please review
> >> it as soon as possible.
> >>
> >> Thanks!
> >>
> >> =E5=9C=A8 2023/12/12 =E4=B8=8B=E5=8D=885:30, Heng Qi =E5=86=99=E9=81=
=93:
> >>>
> >>> =E5=9C=A8 2023/12/12 =E4=B8=8B=E5=8D=885:23, Heng Qi =E5=86=99=E9=81=
=93:
> >>>>
> >>>> =E5=9C=A8 2023/12/12 =E4=B8=8B=E5=8D=884:44, Michael S. Tsirkin =E5=
=86=99=E9=81=93:
> >>>>> On Tue, Dec 12, 2023 at 11:28:21AM +0800, Heng Qi wrote:
> >>>>>> =E5=9C=A8 2023/12/12 =E4=B8=8A=E5=8D=8812:35, Michael S. Tsirkin =
=E5=86=99=E9=81=93:
> >>>>>>> On Mon, Dec 11, 2023 at 05:11:59PM +0800, Heng Qi wrote:
> >>>>>>>> virtio-net works in a virtualized system and is somewhat
> >>>>>>>> different from
> >>>>>>>> physical nics. One of the differences is that to save virtio dev=
ice
> >>>>>>>> resources, rx may receive partially checksummed packets. However=
,
> >>>>>>>> XDP may
> >>>>>>>> cause partially checksummed packets to be dropped.
> >>>>>>>> So XDP loading currently conflicts with the feature
> >>>>>>>> VIRTIO_NET_F_GUEST_CSUM.
> >>>>>>>>
> >>>>>>>> This patch lets the device to supply fully checksummed packets t=
o
> >>>>>>>> the driver.
> >>>>>>>> Then XDP can coexist with VIRTIO_NET_F_GUEST_CSUM to enjoy the
> >>>>>>>> benefits of
> >>>>>>>> device validation checksum.
> >>>>>>>>
> >>>>>>>> In addition, implementation of some performant devices always do
> >>>>>>>> not generate
> >>>>>>>> partially checksummed packets, but the standard driver still nee=
d
> >>>>>>>> to clear
> >>>>>>>> VIRTIO_NET_F_GUEST_CSUM when XDP is there.
> >>>>>>>> A new feature VIRTIO_NET_F_GUEST_FULLY_CSUM is added to solve th=
e
> >>>>>>>> above
> >>>>>>>> situation, which provides the driver with configurable offload.
> >>>>>>>> If the offload is enabled, then the device must deliver fully
> >>>>>>>> checksummed packets to the driver and may validate the checksum.
> >>>>>>>>
> >>>>>>>> Use case example:
> >>>>>>>> If VIRTIO_NET_F_GUEST_FULLY_CSUM is negotiated and the offload i=
s
> >>>>>>>> enabled,
> >>>>>>>> after XDP processes a fully checksummed packet, the
> >>>>>>>> VIRTIO_NET_HDR_F_DATA_VALID bit
> >>>>>>>> is retained if the device has validated its checksum, resulting
> >>>>>>>> in the guest
> >>>>>>>> not needing to validate the checksum again. This is useful for
> >>>>>>>> guests:
> >>>>>>>>      1. Bring the driver advantages such as cpu savings.
> >>>>>>>>      2. For devices that do not generate partially checksummed
> >>>>>>>> packets themselves,
> >>>>>>>>         XDP can be loaded in the driver without modifying the
> >>>>>>>> hardware behavior.
> >>>>>>>>
> >>>>>>>> Several solutions have been discussed in the previous proposal[1=
].
> >>>>>>>> After historical discussion, we have tried the method proposed b=
y
> >>>>>>>> Jason[2],
> >>>>>>>> but some complex scenarios and challenges are difficult to deal
> >>>>>>>> with.
> >>>>>>>> We now return to the method suggested in [1].
> >>>>>>>>
> >>>>>>>> [1]
> >>>>>>>> https://lists.oasis-open.org/archives/virtio-dev/202305/msg00291=
.html
> >>>>>>>>
> >>>>>>>> [2]
> >>>>>>>> https://lore.kernel.org/all/20230628030506.2213-1-hengqi@linux.a=
libaba.com/
> >>>>>>>>
> >>>>>>>> Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
> >>>>>>>> Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> >>>>>>>> ---
> >>>>>>>> v4->v5:
> >>>>>>>> - Remove the modification to the GUEST_CSUM.
> >>>>>>>> - The description of this feature has been reorganized for
> >>>>>>>> greater clarity.
> >>>>>>>>
> >>>>>>>> v3->v4:
> >>>>>>>> - Streamline some repetitive descriptions. @Jason
> >>>>>>>> - Add how features should work, when to be enabled, and overhead=
.
> >>>>>>>> @Jason @Michael
> >>>>>>>>
> >>>>>>>> v2->v3:
> >>>>>>>> - Add a section named "Driver Handles Fully Checksummed Packets"
> >>>>>>>>      and more descriptions. @Michael
> >>>>>>>>
> >>>>>>>> v1->v2:
> >>>>>>>> - Modify full checksum functionality as a configurable offload
> >>>>>>>>      that is initially turned off. @Jason
> >>>>>>>>
> >>>>>>>>     device-types/net/description.tex        | 74
> >>>>>>>> +++++++++++++++++++++++--
> >>>>>>>>     device-types/net/device-conformance.tex |  1 +
> >>>>>>>>     device-types/net/driver-conformance.tex |  1 +
> >>>>>>>>     introduction.tex                        |  3 +
> >>>>>>>>     4 files changed, 73 insertions(+), 6 deletions(-)
> >>>>>>>>
> >>>>>>>> diff --git a/device-types/net/description.tex
> >>>>>>>> b/device-types/net/description.tex
> >>>>>>>> index aff5e08..ab6c13d 100644
> >>>>>>>> --- a/device-types/net/description.tex
> >>>>>>>> +++ b/device-types/net/description.tex
> >>>>>>>> @@ -122,6 +122,9 @@ \subsection{Feature bits}\label{sec:Device
> >>>>>>>> Types / Network Device / Feature bits
> >>>>>>>>         device with the same MAC address.
> >>>>>>>>     \item[VIRTIO_NET_F_SPEED_DUPLEX(63)] Device reports speed an=
d
> >>>>>>>> duplex.
> >>>>>>>> +
> >>>>>>>> +\item[VIRTIO_NET_F_GUEST_FULLY_CSUM (64)] Device delivers fully
> >>>>>>>> checksummed packets
> >>>>>>>> +    to the driver and may validate the checksum.
> >>>>>>>>     \end{description}
> >>>>>>> I propose
> >>>>>>> VIRTIO_NET_F_GUEST_CSUM_COMPLETE
> >>>>>>> instead.
> >>>>>> Can I ask here if *complete* in VIRTIO_NET_F_GUEST_CSUM_COMPLETE a=
nd
> >>>>>> CHECKSUM_COMPLETE mean the same thing?
> >>>>>>
> >>>>>> If so, it seems that it's no longer the same as the description of
> >>>>>> this
> >>>>>> patch.
> >>>>> Oh. I thought it is. Then I guess I misunderstand what this patch i=
s
> >>>>> supposed to be doing, again.
> >>>> Here's some context:
> >>>>
> >>>>  From the perspective of the Linux kernel, the GUEST_CSUM feature is
> >>>> negotiated to support
> >>>> (1)  CHECKSUM_NONE, (2) CHECKSUM_UNNECESSARY, (3) CHECKSUM_PARTIAL,
> >>>> which
> >>>> respectively correspond to (1) the device does not validate the
> >>>> packet checksum (may not have
> >>>> the ability to validate some protocols or does not recognize the
> >>>> packet); (2) the device has verified
> >>>> the data packet, then sets DATA_VALID bit in flags; (3) In order to
> >>>> save device resources, VMs
> >>>> on the same host deliver partially checksummed packets, and
> >>>> NEEDS_CSUM bit is set in flags.
> >>>>
> >>>> GUEST_FULLY_CSUM did not change the above result.
> >>> Sorry, GUEST_FULLY_CSUM prohibits the third(3) action.
> >>>
> >>>>>
> >>>>>>>>     \subsubsection{Feature bit requirements}\label{sec:Device
> >>>>>>>> Types / Network Device / Feature bits / Feature bit requirements=
}
> >>>>>>>> @@ -136,6 +139,7 @@ \subsubsection{Feature bit
> >>>>>>>> requirements}\label{sec:Device Types / Network Device
> >>>>>>>>     \item[VIRTIO_NET_F_GUEST_UFO] Requires VIRTIO_NET_F_GUEST_CS=
UM.
> >>>>>>>>     \item[VIRTIO_NET_F_GUEST_USO4] Requires VIRTIO_NET_F_GUEST_C=
SUM.
> >>>>>>>>     \item[VIRTIO_NET_F_GUEST_USO6] Requires VIRTIO_NET_F_GUEST_C=
SUM.
> >>>>>>>> +\item[VIRTIO_NET_F_GUEST_FULLY_CSUM] Requires
> >>>>>>>> VIRTIO_NET_F_GUEST_CSUM and VIRTIO_NET_F_CTRL_GUEST_OFFLOADS.
> >>>>>>>
> >>>>>>>>     \item[VIRTIO_NET_F_HOST_TSO4] Requires VIRTIO_NET_F_CSUM.
> >>>>>>>>     \item[VIRTIO_NET_F_HOST_TSO6] Requires VIRTIO_NET_F_CSUM.
> >>>>>>>> @@ -398,6 +402,58 @@ \subsection{Device
> >>>>>>>> Initialization}\label{sec:Device Types / Network Device / Dev
> >>>>>>>>     A truly minimal driver would only accept VIRTIO_NET_F_MAC an=
d
> >>>>>>>> ignore
> >>>>>>>>     everything else.
> >>>>>>>> +\subsubsection{Device Delivers Fully Checksummed
> >>>>>>>> Packets}\label{sec:Device Types / Network Device / Device
> >>>>>>>> Initialization / Device Delivers Fully Checksummed Packets}
> >>>>>>>> +
> >>>>>>>> +If the feature VIRTIO_NET_F_GUEST_FULLY_CSUM is negotiated, the
> >>>>>>>> driver can
> >>>>>>>> +benefit from the device's ability to calculate and validate the
> >>>>>>>> checksum.
> >>>>>>>> +
> >>>>>>>> +If the feature VIRTIO_NET_F_GUEST_FULLY_CSUM is negotiated,
> >>>>>>>> +the device behaves as follows:
> >>>>>>>> +\begin{itemize}
> >>>>>>>> +  \item The device delivers a fully checksummed packet to the
> >>>>>>>> driver rather than a partially checksummed packet.
> >>>>>>> where does "partially checksummed packet" come from?
> >>>>>>> I think it comes from:
> >>>>>> Yes, you are right.
> >>>>>>
> >>>>>>>       The VIRTIO_NET_F_GUEST_CSUM feature indicates that partiall=
y
> >>>>>>>      checksummed packets can be received, and if it can do that t=
hen
> >>>>>>>      the VIRTIO_NET_F_GUEST_TSO4, VIRTIO_NET_F_GUEST_TSO6,
> >>>>>>>      VIRTIO_NET_F_GUEST_UFO, VIRTIO_NET_F_GUEST_ECN,
> >>>>>>> VIRTIO_NET_F_GUEST_USO4
> >>>>>>>      and VIRTIO_NET_F_GUEST_USO6 are the input equivalents of the
> >>>>>>> features described above.
> >>>>>>>      See \ref{sec:Device Types / Network Device / Device Operatio=
n /
> >>>>>>>
> >>>>>>>
> >>>>>>> so that one needs to be updated too.
> >>>>>> Will update this.
> >>>>>>
> >>>>>>>> +Partially checksummed packets come from TCP/UDP protocols
> >>>>>>>> \ref{devicenormative:Device Types / Network Device / Device
> >>>>>>>> Operation / Processing of Packets}.
> >>>>>>>> +  \item The device may validate the packet checksum before
> >>>>>>>> delivering it.
> >>>>>>>> +If the packet checksum has been verified, the
> >>>>>>>> VIRTIO_NET_HDR_F_DATA_VALID bit
> >>>>>>>> +in \field{flags} is set: in case of multiple encapsulated
> >>>>>>>> protocols, one
> >>>>>>>> +level of checksums has been validated (Just like
> >>>>>>>> VIRTIO_NET_F_GUEST_CSUM does.).
> >>>>>>>> +  \item The device can not set the VIRTIO_NET_HDR_F_NEEDS_CSUM
> >>>>>>>> bit in \field{flags}.
> >>>>>>>> +\end{itemize}
> >>>>>>>> +
> >>>>>>>> +Note that packet types that the driver or device can recognize
> >>>>>>>> and the device
> >>>>>>>> +may verify will not change due to the additional negotiated
> >>>>>>>> VIRTIO_NET_F_GUEST_FULLY_CSUM.
> >>>>>>>> +These remain consistent with VIRTIO_NET_F_GUEST_CSUM.
> >>>>>>> This part is confusing. "change" and "remain" makes no sense for
> >>>>>>> someone reading
> >>>>>>> the spec text as opposed to reviewing the patch.
> >>>>>>> also it does not matter whether VIRTIO_NET_F_GUEST_FULLY_CSUM
> >>>>>>> is negotiated right? it only matters whether it is enabled.
> >>>>>> Right! And following your suggestion, I plan to rewrite it as foll=
ows:
> >>>>>>
> >>>>>> Note that if VIRTIO_NET_F_GUEST_FULLY_CSUM is additionally
> >>>>>> negotiated and
> >>>>>> its offload is enabled, packet types that the driver or device can
> >>>>>> recognize
> >>>>>> and the
> >>>>>> device may verify are consistent with when VIRTIO_NET_F_GUEST_CSUM=
 is
> >>>>>> negotiated.
> >>>>> This doesn't really clarify.  If you'd like it put more simply: Nev=
er
> >>>>> imagine yourself not to be otherwise than what it might appear to
> >>>>> others
> >>>>> that what you were or might have been was not otherwise than what y=
ou
> >>>>> had been would have appeared to them to be otherwise.
> >>>> Sorry, I'm not a native speaker and didn't quite understand this lon=
g
> >>>> sentence.
> >>>> But I think you suggest that I should not explain something from the
> >>>> perspective
> >>>> of someone who is already familiar with it, but should try to explai=
n
> >>>> it clearly
> >>>> for readers who are not familiar with it.
> >>>>
> >>>> I'll try to explain it more clearly.
> >>>>
> >>>>>>>> +Specific transport protocols that may have
> >>>>>>>> VIRTIO_NET_HDR_F_DATA_VALID set
> >>>>>>>> +in \field{flags} include TCP, UDP, GRE (Generic Routing
> >>>>>>>> Encapsulation),
> >>>>>>>> +and SCTP (Stream Control Transmission Protocol).
> >>>>>>>> +A fully checksummed packet's checksum field for each of the
> >>>>>>>> above protocols
> >>>>>>>> +is set to a calculated value that covers the transport header
> >>>>>>>> and payload
> >>>>>>>> +(TCP or UDP involves the additional pseudo header) of the packe=
t.
> >>>>>>>> +
> >>>>>>>> +Delivering fully checksummed packets rather than partially
> >>>>>>>> +checksummed packets incurs additional overhead for the device.
> >>>>>>>> +The overhead varies from device to device, for example the
> >>>>>>>> overhead of
> >>>>>>>> +calculating and validating the packet checksum is a few
> >>>>>>>> microseconds
> >>>>>>>> +for a hardware device.
> >>>>>>> wow really is that standard? There are devices that deliver the w=
hole
> >>>>>>> packet in a few microseconds. Maybe "for some hardware devices"?
> >>>>>> Ok, I think it's more accurate.
> >>>>>>
> >>>>>>>> +
> >>>>>>>> +The feature VIRTIO_NET_F_GUEST_FULLY_CSUM has a corresponding
> >>>>>>>> offload \ref{sec:Device Types / Network Device / Device Operatio=
n
> >>>>>>>> / Control Virtqueue / Offloads State Configuration},
> >>>>>>>> +which when enabled means that the device delivers fully
> >>>>>>>> checksummed packets
> >>>>>>>> +to the driver and may validate the checksum.
> >>>>>>>> +The offload is disabled by default.
> >>>>>>> This is unusual, unlike any other offload. So needs to be stresse=
d
> >>>>>>> more.  And what does "default" mean here?
> >>>>>>> E.g. "Note: unlike other offloads, this offloads is disabled
> >>>>>>> even after VIRTIO_NET_F_GUEST_FULLY_CSUM has been negotiation.
> >>>>>> Ok. Will rewrite this following your example.
> >>>>>>
> >>>>>>> The offload has to be enabled ... "
> >>>>>>>
> >>>>>>>
> >>>>>>>> +
> >>>>>>>> +The driver can enable the offload by sending the
> >>>>>>>> +VIRTIO_NET_CTRL_GUEST_OFFLOADS_SET command with the
> >>>>>>>> +VIRTIO_NET_F_GUEST_FULLY_CSUM bit set when, for example,
> >>>>>>>> +eXpress Data Path (XDP) \hyperref[intro:xdp]{[XDP]} is function=
ing.
> >>>>>>> It is not worth adding a spec link just to provide an example.
> >>>>>>> If you really want to provide it:
> >>>>>>> "eXpress Data Path (XDP) in Linux is active".
> >>>>>>>
> >>>>>>> But this is the problem this patch does not solve in my opinion.
> >>>>>>> A device might actually provide a full checksum
> >>>>>>> at negligeable extra cost and driver will still keep it off by
> >>>>>>> default.
> >>>>>>> So it slows device down - when does it make sense to enable this
> >>>>>>> feature?
> >>>>>>> Just giving an example of XDP is not sufficient.
> >>>>>> First of all, I think the core purpose of this patch is to support=
 XDP
> >>>>>> loading.
> >>>>>> Otherwise, I think GUEST_CSUM works just fine.
> >>>>>>
> >>>>>> 1. The device is performant, even if only GUEST_CSUM is negotiated=
,
> >>>>>> the
> >>>>>> device only provide fully checksummed packets.
> >>>>>> If the offload of GUEST_FULLY_CSUM is disabled, it is equivalent t=
o
> >>>>>> only
> >>>>>> GUEST_CSUM working, and the device still
> >>>>>> provides fully checksummed packets. This will not slow the device
> >>>>>> down.
> >>>>>>
> >>>>>> 2. For example a sw device. If the device only negotiates
> >>>>>> GUEST_CSUM, it may
> >>>>>> provide partially checksummed packets.
> >>>>>> In the absence of XDP loading requirements, the driver does not
> >>>>>> need to
> >>>>>> enable GUEST_FULLY_CSUM offload.
> >>>>> Well first of all I am no longer even sure what this GUEST_FULLY_CS=
UM
> >>>>> does. I thought it is CHECKSUM_COMPLETE.
> >>>>> But more generally, is there an assumption driver will not
> >>>>> enable this new checksum typically then? Unless what? If we never
> >>>>> tell drivers they should not enable it they will, the
> >>>>> fact that it's off by default seems to be a hint that it
> >>>>> is typically a bad idea to enable it. But when is it a good idea?
> >>>> I think the core difference between GUEST_FULLY_CSUM and GUEST_CSUM
> >>>> is that
> >>>> GUEST_CSUM may generate partially checksummed TCP/UDP packets,
> >>>> causing xdp to fail to load.
> >>>> GUEST_FULLY_CSUM forces fully checksummed TCP/UDP packets to be
> >>>> generated so xdp can load.
> >>>> For the rest, I guess there is no difference between GUEST_FULLY_CSU=
M
> >>>> and GUEST_CSUM.
> >>>>
> >>>> As for when the driver enables the offload, I think I have already
> >>>> mentioned:
> >>>> Enable this offload in the interface where XDP is loaded,
> >>>> Disable this offload in the interfaces where XDP is unloaded.
> >>>>
> >>>> Thanks=EF=BC=81
> >>>>
> >>>>>
> >>>>>>>
> >>>>>>>> +
> >>>>>>>> +\drivernormative{\subsubsection}{Device Delivers Fully
> >>>>>>>> Checksummed Packets}{sec:Device Types / Network Device / Device
> >>>>>>>> Initialization / Device Delivers Fully Checksummed Packets}
> >>>>>>>> +
> >>>>>>>> +The driver MUST NOT enable the offload for which
> >>>>>>>> VIRTIO_NET_F_GUEST_FULLY_CSUM has not been negotiated.
> >>>>>>> what does "the offload for which" mean here?
> >>>>>> VIRTIO_NET_F_GUEST_FULLY_CSUM's offload
> >>>>>>
> >>>>>>> and how is this special for VIRTIO_NET_F_GUEST_FULLY_CSUM?
> >>>>>> Well, I think this sentence seems a bit redundant and I'll probabl=
y
> >>>>>> remove
> >>>>>> this.
> >>>>>>
> >>>>>>>> +\devicenormative{\subsubsection}{Device Delivers Fully
> >>>>>>>> Checksummed Packets}{sec:Device Types / Network Device / Device
> >>>>>>>> Initialization / Device Delivers Fully Checksummed Packets}
> >>>>>>>> +
> >>>>>>>> +Upon the device reset, the device MUST disable the offload.
> >>>>>>>> +
> >>>>>>> reset has nothing to do with it I think. it's about feature
> >>>>>>> negotiation.
> >>>>>> Will modify this.
> >>>>>>
> >>>>>> Thanks a lot!
> >>>>>>
> >>>>>>>>     \subsection{Device Operation}\label{sec:Device Types / Netwo=
rk
> >>>>>>>> Device / Device Operation}
> >>>>>>>>     Packets are transmitted by placing them in the
> >>>>>>>> @@ -723,7 +779,8 @@ \subsubsection{Processing of Incoming
> >>>>>>>> Packets}\label{sec:Device Types / Network
> >>>>>>>>       \field{num_buffers} is one, then the entire packet will be
> >>>>>>>>       contained within this buffer, immediately following the st=
ruct
> >>>>>>>>       virtio_net_hdr.
> >>>>>>>> -\item If the VIRTIO_NET_F_GUEST_CSUM feature was negotiated, th=
e
> >>>>>>>> +\item If the VIRTIO_NET_F_GUEST_CSUM feature (regardless of whe=
ther
> >>>>>>>> +  VIRTIO_NET_F_GUEST_FULLY_CSUM was negotiated) was negotiated,=
 the
> >>>>>>>>       VIRTIO_NET_HDR_F_DATA_VALID bit in \field{flags} can be
> >>>>>>>>       set: if so, device has validated the packet checksum.
> >>>>>>>>       In case of multiple encapsulated protocols, one level of
> >>>>>>>> checksums
> >>>>>>>> @@ -747,7 +804,8 @@ \subsubsection{Processing of Incoming
> >>>>>>>> Packets}\label{sec:Device Types / Network
> >>>>>>>>       number of coalesced TCP segments in \field{csum_start} fie=
ld
> >>>>>>>> and
> >>>>>>>>       number of duplicated ACK segments in \field{csum_offset} f=
ield
> >>>>>>>>       and sets bit VIRTIO_NET_HDR_F_RSC_INFO in \field{flags}.
> >>>>>>>> -\item If the VIRTIO_NET_F_GUEST_CSUM feature was negotiated, th=
e
> >>>>>>>> +\item If the VIRTIO_NET_F_GUEST_CSUM feature was negotiated but=
 the
> >>>>>>>> +  VIRTIO_NET_F_GUEST_FULLY_CSUM feature was not negotiated, the
> >>>>>>>>       VIRTIO_NET_HDR_F_NEEDS_CSUM bit in \field{flags} can be
> >>>>>>>>       set: if so, the packet checksum at offset \field{csum_offs=
et}
> >>>>>>>>       from \field{csum_start} and any preceding checksums
> >>>>>>>> @@ -805,8 +863,9 @@ \subsubsection{Processing of Incoming
> >>>>>>>> Packets}\label{sec:Device Types / Network
> >>>>>>>>     device MUST set the VIRTIO_NET_HDR_GSO_ECN bit in
> >>>>>>>>     \field{gso_type}.
> >>>>>>>> -If the VIRTIO_NET_F_GUEST_CSUM feature has been negotiated, the
> >>>>>>>> -device MAY set the VIRTIO_NET_HDR_F_NEEDS_CSUM bit in
> >>>>>>>> +If the VIRTIO_NET_F_GUEST_CSUM feature has been negotiated but
> >>>>>>>> +the VIRTIO_NET_F_GUEST_FULLY_CSUM feature has not been negotiat=
ed,
> >>>>>>>> +the device MAY set the VIRTIO_NET_HDR_F_NEEDS_CSUM bit in
> >>>>>>>>     \field{flags}, if so:
> >>>>>>>>     \begin{enumerate}
> >>>>>>>>     \item the device MUST validate the packet checksum at
> >>>>>>>> @@ -826,7 +885,8 @@ \subsubsection{Processing of Incoming
> >>>>>>>> Packets}\label{sec:Device Types / Network
> >>>>>>>>     been negotiated, the device MUST set \field{gso_type} to
> >>>>>>>>     VIRTIO_NET_HDR_GSO_NONE.
> >>>>>>>> -If \field{gso_type} differs from VIRTIO_NET_HDR_GSO_NONE, then
> >>>>>>>> +If the VIRTIO_NET_F_GUEST_FULLY_CSUM feature has not been
> >>>>>>>> negotiated and
> >>>>>>>> +\field{gso_type} differs from VIRTIO_NET_HDR_GSO_NONE, then
> >>>>>>>>     the device MUST also set the VIRTIO_NET_HDR_F_NEEDS_CSUM bit=
 in
> >>>>>>>>     \field{flags} MUST set \field{gso_size} to indicate the
> >>>>>>>> desired MSS.
> >>>>>>>>     If VIRTIO_NET_F_RSC_EXT was negotiated, the device MUST also
> >>>>>>>> @@ -842,7 +902,8 @@ \subsubsection{Processing of Incoming
> >>>>>>>> Packets}\label{sec:Device Types / Network
> >>>>>>>>     not less than the length of the headers, including the trans=
port
> >>>>>>>>     header.
> >>>>>>>> -If the VIRTIO_NET_F_GUEST_CSUM feature has been negotiated, the
> >>>>>>>> +If the VIRTIO_NET_F_GUEST_CSUM feature (regardless of whether
> >>>>>>>> +VIRTIO_NET_F_GUEST_FULLY_CSUM has been negotiated) has been
> >>>>>>>> negotiated, the
> >>>>>>>>     device MAY set the VIRTIO_NET_HDR_F_DATA_VALID bit in
> >>>>>>>>     \field{flags}, if so, the device MUST validate the packet
> >>>>>>>>     checksum (in case of multiple encapsulated protocols, one le=
vel
> >>>>>>>> @@ -1633,6 +1694,7 @@ \subsubsection{Control
> >>>>>>>> Virtqueue}\label{sec:Device Types / Network Device / Devi
> >>>>>>>>     #define VIRTIO_NET_F_GUEST_UFO        10
> >>>>>>>>     #define VIRTIO_NET_F_GUEST_USO4       54
> >>>>>>>>     #define VIRTIO_NET_F_GUEST_USO6       55
> >>>>>>>> +#define VIRTIO_NET_F_GUEST_FULLY_CSUM 64
> >>>>>>>>     #define VIRTIO_NET_CTRL_GUEST_OFFLOADS       5
> >>>>>>>>      #define VIRTIO_NET_CTRL_GUEST_OFFLOADS_SET   0
> >>>>>>>> diff --git a/device-types/net/device-conformance.tex
> >>>>>>>> b/device-types/net/device-conformance.tex
> >>>>>>>> index 52526e4..43b3921 100644
> >>>>>>>> --- a/device-types/net/device-conformance.tex
> >>>>>>>> +++ b/device-types/net/device-conformance.tex
> >>>>>>>> @@ -16,4 +16,5 @@
> >>>>>>>>     \item \ref{devicenormative:Device Types / Network Device /
> >>>>>>>> Device Operation / Control Virtqueue / Notifications Coalescing}
> >>>>>>>>     \item \ref{devicenormative:Device Types / Network Device /
> >>>>>>>> Device Operation / Control Virtqueue / Inner Header Hash}
> >>>>>>>>     \item \ref{devicenormative:Device Types / Network Device /
> >>>>>>>> Device Operation / Control Virtqueue / Device Statistics}
> >>>>>>>> +\item \ref{devicenormative:Device Types / Network Device /
> >>>>>>>> Device Initialization / Device Delivers Fully Checksummed Packet=
s}
> >>>>>>>>     \end{itemize}
> >>>>>>>> diff --git a/device-types/net/driver-conformance.tex
> >>>>>>>> b/device-types/net/driver-conformance.tex
> >>>>>>>> index c693c4f..c9b6d1b 100644
> >>>>>>>> --- a/device-types/net/driver-conformance.tex
> >>>>>>>> +++ b/device-types/net/driver-conformance.tex
> >>>>>>>> @@ -16,4 +16,5 @@
> >>>>>>>>     \item \ref{drivernormative:Device Types / Network Device /
> >>>>>>>> Device Operation / Control Virtqueue / Notifications Coalescing}
> >>>>>>>>     \item \ref{drivernormative:Device Types / Network Device /
> >>>>>>>> Device Operation / Control Virtqueue / Inner Header Hash}
> >>>>>>>>     \item \ref{drivernormative:Device Types / Network Device /
> >>>>>>>> Device Operation / Control Virtqueue / Device Statistics}
> >>>>>>>> +\item \ref{drivernormative:Device Types / Network Device /
> >>>>>>>> Device Initialization / Device Delivers Fully Checksummed Packet=
s}
> >>>>>>>>     \end{itemize}
> >>>>>>>> diff --git a/introduction.tex b/introduction.tex
> >>>>>>>> index cfa6633..fc99597 100644
> >>>>>>>> --- a/introduction.tex
> >>>>>>>> +++ b/introduction.tex
> >>>>>>>> @@ -145,6 +145,9 @@ \section{Normative
> >>>>>>>> References}\label{sec:Normative References}
> >>>>>>>>         Leiba, B., "Ambiguity of Uppercase vs Lowercase in RFC
> >>>>>>>> 2119 Key Words", BCP
> >>>>>>>>         14, RFC 8174, DOI 10.17487/RFC8174, May 2017
> >>>>>>>> \newline\url{http://www.ietf.org/rfc/rfc8174.txt}\\
> >>>>>>>> +    \phantomsection\label{intro:xdp}\textbf{[XDP]} &
> >>>>>>>> +    eXpress Data Path(XDP) provides a high performance,
> >>>>>>>> programmable network data path in the Linux kernel.
> >>>>>>>> +
> >>>>>>>> \newline\url{https://prototype-kernel.readthedocs.io/en/latest/n=
etworking/XDP/}\\
> >>>>>>>>     \end{longtable}
> >>>>>>>>     \section{Non-Normative References}
> >>>>>>>> --
> >>>>>>>> 2.19.1.6.gb485710b
> >>>>> This publicly archived list offers a means to provide input to the
> >>>>> OASIS Virtual I/O Device (VIRTIO) TC.
> >>>>>
> >>>>> In order to verify user consent to the Feedback License terms and
> >>>>> to minimize spam in the list archive, subscription is required
> >>>>> before posting.
> >>>>>
> >>>>> Subscribe: virtio-comment-subscribe@lists.oasis-open.org
> >>>>> Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
> >>>>> List help: virtio-comment-help@lists.oasis-open.org
> >>>>> List archive: https://lists.oasis-open.org/archives/virtio-comment/
> >>>>> Feedback License:
> >>>>> https://www.oasis-open.org/who/ipr/feedback_license.pdf
> >>>>> List Guidelines:
> >>>>> https://www.oasis-open.org/policies-guidelines/mailing-lists
> >>>>> Committee: https://www.oasis-open.org/committees/virtio/
> >>>>> Join OASIS: https://www.oasis-open.org/join/
> >>>>
> >>>> This publicly archived list offers a means to provide input to the
> >>>> OASIS Virtual I/O Device (VIRTIO) TC.
> >>>>
> >>>> In order to verify user consent to the Feedback License terms and
> >>>> to minimize spam in the list archive, subscription is required
> >>>> before posting.
> >>>>
> >>>> Subscribe: virtio-comment-subscribe@lists.oasis-open.org
> >>>> Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
> >>>> List help: virtio-comment-help@lists.oasis-open.org
> >>>> List archive: https://lists.oasis-open.org/archives/virtio-comment/
> >>>> Feedback License:
> >>>> https://www.oasis-open.org/who/ipr/feedback_license.pdf
> >>>> List Guidelines:
> >>>> https://www.oasis-open.org/policies-guidelines/mailing-lists
> >>>> Committee: https://www.oasis-open.org/committees/virtio/
> >>>> Join OASIS: https://www.oasis-open.org/join/
> >>>
> >>> This publicly archived list offers a means to provide input to the
> >>> OASIS Virtual I/O Device (VIRTIO) TC.
> >>>
> >>> In order to verify user consent to the Feedback License terms and
> >>> to minimize spam in the list archive, subscription is required
> >>> before posting.
> >>>
> >>> Subscribe: virtio-comment-subscribe@lists.oasis-open.org
> >>> Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
> >>> List help: virtio-comment-help@lists.oasis-open.org
> >>> List archive: https://lists.oasis-open.org/archives/virtio-comment/
> >>> Feedback License: https://www.oasis-open.org/who/ipr/feedback_license=
.pdf
> >>> List Guidelines:
> >>> https://www.oasis-open.org/policies-guidelines/mailing-lists
> >>> Committee: https://www.oasis-open.org/committees/virtio/
> >>> Join OASIS: https://www.oasis-open.org/join/
> >
> > This publicly archived list offers a means to provide input to the
> > OASIS Virtual I/O Device (VIRTIO) TC.
> >
> > In order to verify user consent to the Feedback License terms and
> > to minimize spam in the list archive, subscription is required
> > before posting.
> >
> > Subscribe: virtio-comment-subscribe@lists.oasis-open.org
> > Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
> > List help: virtio-comment-help@lists.oasis-open.org
> > List archive: https://lists.oasis-open.org/archives/virtio-comment/
> > Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.p=
df
> > List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing=
-lists
> > Committee: https://www.oasis-open.org/committees/virtio/
> > Join OASIS: https://www.oasis-open.org/join/
>


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

