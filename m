Return-Path: <virtio-dev-return-14181-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9AC9C46CCD
	for <virtio-dev@archiver.kernel.org>; Thu, 21 Dec 2023 01:35:42 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id DFDFC330BD
	for <virtio-dev@archiver.kernel.org>; Thu, 21 Dec 2023 01:35:40 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id CBAE8986605
	for <virtio-dev@archiver.kernel.org>; Thu, 21 Dec 2023 01:35:40 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id BE6939863C9; Thu, 21 Dec 2023 01:35:40 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 63AE69865B6
	for <virtio-dev@lists.oasis-open.org>; Thu, 21 Dec 2023 01:34:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: QJFlE8nJO0yTyqHM18YI8Q-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703122462; x=1703727262;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ibbfMT7rZyYdbpT52435lHwgJU2FZmzX4Bsh00vjk5g=;
        b=FCkrSaxzFdWJNPBBkZfxSZaw8h7JvA3gRg3tnTnc08Ow1HgFEb3CNwjr4ru0roZvn5
         +uTlXR6dEjtglimV0HqxMa67Nf39usKAOC7zDj8pvAOAuRm2Lu3StodqtXzwOAyaXN4f
         anxFbvfHpGUwY2U4RG4KLbQrh2bS+nY7llzbZErMofVScGBgn8m3KK+XWbJC9iS26/Q6
         7uDqTRMQZ4IzxlosilE8nqBR2idj14rf5m2GMQuHzs6sfn87/T2GtjQwLm+JWjXCWGFt
         M3m01xN3/SM3E6c/uGJ4YuwVztxfaEsmnflFIJINmx8ok7pOc8HT8Bt+0veqySDSvQs4
         wcmQ==
X-Gm-Message-State: AOJu0YztLPBwdOMclzxloAgwxz7e4WvtKk6QKKx67+FgUH3ikmjX8ftC
	BwYHV1u9kvUpUWdA8ceSyGd3Kr6gz77epk39IdZokcQhVCMGGnwZ+8yKGCRdmYP/i4jA8KTJiTM
	TYLzQq4lStO0LP4b9+2t7r0JYXscNIS3qyhWxTkcJdFDSiwj4+EaG7Aw=
X-Received: by 2002:a17:902:d508:b0:1d3:52ec:fa53 with SMTP id b8-20020a170902d50800b001d352ecfa53mr17313758plg.74.1703122461558;
        Wed, 20 Dec 2023 17:34:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG8nKktmppvOXZTH2ywRPk6a0zSd+W71qxUFpOsLWSkn97OVeTfTeMIZl1hDlr2QnsbewksGzcj5zWOd7z6Nqg=
X-Received: by 2002:a17:902:d508:b0:1d3:52ec:fa53 with SMTP id
 b8-20020a170902d50800b001d352ecfa53mr17313728plg.74.1703122460704; Wed, 20
 Dec 2023 17:34:20 -0800 (PST)
MIME-Version: 1.0
References: <959e1a7ccdfffaaadd865a627924cf492ce22bfa.1702277523.git.hengqi@linux.alibaba.com>
 <20231211110350-mutt-send-email-mst@kernel.org> <a8ba676e-de43-45ae-a6a8-a67d0dd41c1f@linux.alibaba.com>
 <20231212032713-mutt-send-email-mst@kernel.org> <bfd25f86-4292-45d2-a7a2-fe61bde0edb4@linux.alibaba.com>
 <b739d275-3664-4509-8a91-f19690719475@linux.alibaba.com> <fafa078b-14f5-460d-b03e-122afb9156ba@linux.alibaba.com>
 <CACGkMEuCb13=-b1yMYi3NOehL+6eNWjWsmBHfcYho1w0HwpVBA@mail.gmail.com>
 <6d9353f7-2899-4ba9-8aef-2431c9362207@linux.alibaba.com> <CACGkMEsh9h_syGag48DL9rSSH2Yp4Ht-ES4gA-5rv16Lih_tJw@mail.gmail.com>
 <df90d58d-7e4e-44d7-8896-5fc5b131c164@linux.alibaba.com> <CACGkMEsxsLP=hnybYi2fiKXFq1U1zo+EuKnzfnbT3K_Wcrug5Q@mail.gmail.com>
 <68b0d00b-8b3b-4bd4-9e7c-c3b811dafd8c@linux.alibaba.com> <CACGkMEt45h=ouZTeM_x_O1vX6Tw=s8WjnyKF9zmHPzhLvytKYw@mail.gmail.com>
 <bf35dbcb-4995-43f4-b6c0-78ffa53199e9@linux.alibaba.com>
In-Reply-To: <bf35dbcb-4995-43f4-b6c0-78ffa53199e9@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 21 Dec 2023 09:34:09 +0800
Message-ID: <CACGkMEsGc7RRTS_o2GD1OCsBgPSLFcaTmdzrPXgm0ZqKSddfZA@mail.gmail.com>
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, 
	Yuri Benditovich <yuri.benditovich@daynix.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [virtio-dev] Re: [virtio-comment] Re: [virtio-dev] Re: [virtio-comment] Re: [PATCH
 v5] virtio-net: device does not deliver partially checksummed packet and may
 validate the checksum

On Wed, Dec 20, 2023 at 3:42=E2=80=AFPM Heng Qi <hengqi@linux.alibaba.com> =
wrote:
>
>
>
> =E5=9C=A8 2023/12/20 =E4=B8=8B=E5=8D=882:59, Jason Wang =E5=86=99=E9=81=
=93:
> > On Wed, Dec 20, 2023 at 2:30=E2=80=AFPM Heng Qi <hengqi@linux.alibaba.c=
om> wrote:
> >>
> >>
> >> =E5=9C=A8 2023/12/20 =E4=B8=8B=E5=8D=881:48, Jason Wang =E5=86=99=E9=
=81=93:
> >>> On Wed, Dec 20, 2023 at 12:07=E2=80=AFAM Heng Qi <hengqi@linux.alibab=
a.com> wrote:
> >>>>
> >>>> =E5=9C=A8 2023/12/19 =E4=B8=8B=E5=8D=883:53, Jason Wang =E5=86=99=E9=
=81=93:
> >>>>> On Mon, Dec 18, 2023 at 12:54=E2=80=AFPM Heng Qi <hengqi@linux.alib=
aba.com> wrote:
> >>>>>> =E5=9C=A8 2023/12/18 =E4=B8=8A=E5=8D=8811:10, Jason Wang =E5=86=99=
=E9=81=93:
> >>>>>>> On Fri, Dec 15, 2023 at 5:51=E2=80=AFPM Heng Qi <hengqi@linux.ali=
baba.com> wrote:
> >>>>>>>> Hi all!
> >>>>>>>>
> >>>>>>>> I would like to ask if anyone has any comments on this version, =
if so
> >>>>>>>> please let me know!
> >>>>>>>> If not, I will collect Michael's comments and publish a new vers=
ion next
> >>>>>>>> Monday.
> >>>>>>> I have a dumb question. (And sorry if I asked it before)
> >>>>>>>
> >>>>>>> Looking at the spec and code. It looks to me DATA_VALID could be =
set
> >>>>>>> without GUEST_CSUM.
> >>>>>> I don't see that in the spec.
> >>>>>> Am I missing something? [1][2]
> >>>>>>
> >>>>>> [1] If the VIRTIO_NET_F_GUEST_CSUM feature was negotiated, the
> >>>>>> VIRTIO_NET_HDR_F_DATA_VALID bit in flags can be set: if so, device=
 has
> >>>>>> validated the packet checksum. In case of multiple encapsulated
> >>>>>> protocols, one level of checksums has been validated.
> >>>>>> Additionally, VIRTIO_NET_F_GUEST_CSUM, TSO4, TSO6, UDP and ECN fea=
tures
> >>>>>> *enable receive checksum*, large receive offload and ECN support w=
hich
> >>>>>> are the input equivalents of the transmit checksum, transmit
> >>>>>> segmentation *offloading* and ECN features, as described in 5.1.6.=
2.
> >>>>>>
> >>>>>> [2] If VIRTIO_NET_F_GUEST_CSUM is not negotiated, the device *MUST=
 set
> >>>>>> flags to zero* and SHOULD supply a fully checksummed packet to the=
 driver.
> >>>>> So this is kind of ambiguous and seems not what I wanted when I wro=
te
> >>>>> the code for DATA_VALID in 2011.
> >>>> Hi Jason, please see below.
> >>>>
> >>>>> NEEDS_CSUM maps to CHECKSUM_PARTIAL which means the packet checksum=
 is
> >>>>> correct.
> >>>> Yes. This mapping is because the PARTIAL checksum usually does not g=
o
> >>>> through the physical wire,
> >>>> so it is considered safe, and the checksum does not need to be verif=
ied.
> >>>>
> >>>>> So spec had
> >>>>>
> >>>>> """
> >>>>> If neither VIRTIO_NET_HDR_F_NEEDS_CSUM nor VIRTIO_NET_HDR_F_DATA_VA=
LID
> >>>>> is set, the driver MUST NOT rely on the packet checksum being corre=
ct.
> >>>>> """
> >>>> Yes. The checksum of a packet without NEEDS_CSUM or has not been
> >>>> verified (DATA_VALID set) is unreliable.
> >>>> This patch doesn't break that.
> >>>>
> >>>>> For DATA_VALID, it maps to CHECKSUM_UNNECESSARY which is mutually
> >>>>> exclusive with CHECKSUM_PARTAIL.
> >>>> Yes. Both cannot be set or appear at the same time.
> >>> So setting both DATA_VALID and NEEDS_CSUM seems ambiguous.
> >>>
> >>> NEEDS_CSUM: the data is correct but the packet doesn't contain checks=
um
> >> This is not containing checksum, the pseudo header checksum is saved i=
n
> >> the checksum field of the transport header.
> > I have a hard time understanding this. But yes, basically I meant the
> > checksum is partial. So the device can't do validation.
>
> If the rx device does receive a partially checksummed packet, but the
> driver requires a fullly
> checksummed packet, then the rx device can help to calculate the full
> checksum for packets.

So this can only happen for virtual devices as hardware devices can't
receive partial csum packets.

>
> >
> >>> DATA_VALID: the checksum has been validated, this implies the packet
> >>> contains a checksum
> >> I'm not sure if both are set at the same time, and even if set,
> >> CHECKSUM_PARTIAL will still work when forwarded.
> >> But why are we discussing this?
> > I don't get this question.
> >
> > As a reviewer, I have the right to raise any issue I spot. This is how
> > the community works.
>
> Sorry I wasn't questioning your question, and I think you captured the
> concerns very well from a nic perspective.

I see, thanks. I want to offer help indeed.

>
> >
> > It is intended to reply to the past discussion
> >
> > 1) like your above statement "Both cannot be set or appear at the same =
time."
> > 2) the example in Linux where CHECKSUM_UNNECESSARY and
> > CHECKSUM_PARTIAL are mutually exclusive.
> >
> >>>>> And this is what Linux did right now:
> >>>>>
> >>>>> For tun_put_user():
> >>>>>
> >>>>>            if (skb->ip_summed =3D=3D CHECKSUM_PARTIAL) {
> >>>>>                    ...
> >>>>>            } else if (has_data_valid &&
> >>>>>                       skb->ip_summed =3D=3D CHECKSUM_UNNECESSARY) {
> >>>>>                       hdr->flags =3D VIRTIO_NET_HDR_F_DATA_VALID;
> >>>>>            } /* else everything is zero */
> >>>>>
> >>>>> This CHECKSUM_UNNECESSARY will work even if GUEST_CSUM is disabled =
if
> >>>>> I was not wrong.
> >>>> I think you are talking about this commit:
> >>>> 10a8d94a95742bb15b4e617ee9884bb4381362be
> >>>>
> >>>> But in fact, as your commit log says, I think this is a hack.
> >>> It's not, see below.
> >>>
> >>>> Host nics
> >>>> does not fall into the scope of virtio spec?
> >>> Seems not, a lot of NIC produces CHECKSUM_UNNECESSARY, I don't see ho=
w
> >>> virtio-net differs in this case.
> >>>
> >>>>> And in receive_buf():
> >>>>>
> >>>>>            if (hdr->hdr.flags & VIRTIO_NET_HDR_F_DATA_VALID)
> >>>>>                    skb->ip_summed =3D CHECKSUM_UNNECESSARY;
> >>>>>
> >>>>> I think we can fix this by safely removing "*MUST set flags to zero=
*"
> >>>>> in [2] from the spec.
> >>>> Sorry. I cannot follow this view.
> >>>>
> >>>> 1. First of all, VIRTIO_NET_F_GUEST_CSUM (partial csum is not consid=
ered
> >>>> now, because we have no dispute about it) does represent the device'=
s
> >>>> ability to calculate and verify checksums.
> >>>> Its ability to handle partial checksums (NEEDS_CSUM) is just a speci=
al
> >>>> processing of virtio, the Linux kernel never had a netdev feature fo=
r
> >>>> partial checksum handling.
> >>>>
> >>>>      1.1 VIRTIO_NET_F_GUEST_{TSO4, TSO6, USO4} etc. depend on
> >>>> VIRTIO_NET_F_GUEST_CSUM.
> >>>>            The reason for being relied upon is not that they are rel=
ated
> >>>> to NEEDS_CSUM, but that the device needs to recalculate and verify t=
he
> >>>> checksum of the packets when merging the packets.
> >>>>            See netdev_fix_features:
> >>>>           if (virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_CSUM))
> >>>>                     dev->features |=3D NETIF_F_RXCSUM;
> >>>>      - netdev_fix_features ->
> >>>>       if (!(features & NETIF_F_RXCSUM)) {
> >>>>                     /* NETIF_F_GRO_HW implies doing RXCSUM since eve=
ry packet
> >>>>                      * successfully merged by hardware must also hav=
e the
> >>>>                      * checksum verified by hardware. If the user do=
es not
> >>>>                      * want to enable RXCSUM, logically, we should d=
isable
> >>>> GRO_HW.
> >>>>                      */
> >>>>                     if (features & NETIF_F_GRO_HW) {
> >>>>                             netdev_dbg(dev, "Dropping NETIF_F_GRO_HW=
 since
> >>>> no RXCSUM feature.\n");
> >>>>                             features &=3D ~NETIF_F_GRO_HW;
> >>>>                     }
> >>>>             }
> >>> Let's leave vitio features just now.
> >>>
> >>> RX checksum offloading usually means the device can do checksum
> >>> validation, so there's no need for the stack to do it again.
> >> YES.
> >>
> >>>    Usually
> >>> devices will produce CHECKSUM_UNNECESSARY packets.
> >> Why do you assume this?
> > It's not an assumption, it's just from the view of how the Linux networ=
k did.
> >
> >> Why do existing virtio devices that comply with virtio 1.0 and later d=
o
> >> this?
> > I say "Let's leave vitio features just now." It means let's just look
> > at what we need for checksumming regardless of virtio.
>
> Ok, virtio nic is also a little different from other Linux nics. For
> example,
> physical nics do not generate partial checksums. Moreover, the virtio
> nics naturally support live migration.

Yes, that's why I explain virtio starting from mapping RXCSUM to
GUEST_CUSM which accepts partial csum.

>
> >
> >> They(virtio devices) will see if VIRTIO_NET_F_GUEST_CSUM is negotiated
> >> and check if the corresponding offload is enabled and if both are YES,
> >> they will validate the checksum. Otherwise, they are non-compliant
> >> virtio devices. Now, in the implementation of various virtio devices s=
uch as
> >> cloud vendor scenarios, how to implement live migration will be a disa=
ster.
> > How does the above destroy live migration?
>
> Please imagine the following scenario:
>
> If the checksum capability of the virtio device has nothing to do with
> whether the GUEST_CSUM feature is negotiated,
> when do we let netdev carry NETIF_F_RXCSUM? and when the user turns off
> the corresponding offload, how do we notify the device?

As explained. RXCSUM is mostly about mandating validation in the
stack. So it's not necessarily require a notification to the device.
Most modern NIC drivers don't care about the rx csum offload. You can
refer to the source.

The reason why virtio is different is that when it can accept partial
csum, it must notify the virtual device to disable TX csum offload, so
the packet will contain a full csum.

>
> For large-scale application of virtio devices, all their management and
> live migration links need to be changed,
> and existing hardware devices need to be updated to allow live migration
> to occur successfully, and migrated to devices that do not
> require GUEST_CSUM instructions.

The changes are only required when new features are added.

Thanks




>
> Thanks!
>
> >
> >> How does A know that it can successfully migrate to B?
> >> The answer is that the same feature is negotiated and has the same
> >> offload status.
> >> Otherwise, users will complain why the performance is so much worse
> >> after migration.
> > There's just too many reasons that can degrade the performance after mi=
gration.
>
>
>
> >
> > Assuming GUEST_CSUM is negotiated, NEEDS_CSUM is not mandated, so the
> > destination device can set less NEEDS_CSUM anyhow.
> >
> >>> Virtio-net wires it to partial csum CHECKSUM_PARTIAL, this is hacky:
> >>>
> >>> 1) it tries to benefit from the TX csum offloading of e.g tuntap
> >>> 2) other path may require hacks or workarounds if it's not a TX path
> >>> from the view of the hypervisor or device (e.g macvtap)
> >>> 3) may not fit for the case of hardware (that can't do GRO_HW but LRO=
)
> >>>
> >>>>      1.2 See NETIF_F_RXCSUM_BIT    /* Receive checksumming offload *=
/
> >>>>         Most device drivers use NETIF_RX_CSUM to indicate device che=
cksum
> >>>> capabilities,
> >>>>         and the corresponding offload can be dynamically switched on=
 and
> >>>> off by user tools such as ethtool.
> >>>>
> >>>> 2. The implementation of vhost-user, large-scale commercial virtio
> >>>> device that I know of, and other devices are
> >>>> completely designed and implemented in accordance with virtio 1.0 an=
d
> >>>> later.
> >>> I think we're not talking about a specific implementation but whether
> >>> the spec description is good or not.
> >> Yes. I'm trying to consider your question from your perspective.
> >>
> >>> DATA_VALID came before 1.0, so
> >>> it's the question whether or not the current description is accurate
> >>> enough for people to implement the device.
> >> Yes, our hundreds of thousands of virtio devices work just fine when
> >> following existing specifications. Migration is no problem either.
> >>
> >> GRO_HW\LRO is also affected by VIRTIO_NET_F_GUEST_CSUM offload.
> > GRO_HW is pretty fine, as GRO can produce partial csum.
> >
> > But LRO is not.
> >
> >>>> They are comply with the current
> >>>> specifications and the Linux kernel's definition of NETIF_F_RXCSUM
> >>>> (VIRTIO_NET_F_GUEST_CSUM).
> >>> So what I'm saying is that, the current Linux can produce DATA_VALID
> >>> without GUEST_CSUM.
> >> I think they need to be fixed.
> > It might be too late to fix them.
> >
> >> Just like when NEEDS_CSUM is set, we
> >> still don't check if GUEST_CSUM is negotiated.
> >>
> >>>    We managed to survive for the past 10+ years.
> >>> Allowing DATA_VALID to be set without GUEST_CSUM seems to be easit
> >>> way.
> >> Live migration can be a disaster.
> > In what sense, live migration works for more than a decade on tuntap. N=
o?
> >
> >>> And when rx checksum offload is disabled, the driver can just not
> >>> set CHECKSUM_UNNECESSARY,
> >> Device verified checksum resources are wasted.
> > True, but it is possible and it is what has been done in some devices.
> > You can see a bunch of examples in the Linux source.
> >
> >> Latency overhead has also been incurred.
> > If you need better latency, you should enable rx checksum offload.
> >
> > Basically, I'm not saying no to your proposal. But we need to figure
> > out what happens first and to find out the best way to solve that.
> >
> > Thanks
> >
> >> Thanks!
> >>
> >>> and this seems something we need to do from
> >>> the view of hardening regardless of this feature.
> >>>
> >>> A side effect is that it disables TSO, but it is intended. Or if you
> >>> want LRO with DATA_VALID, it looks like another story.
> >>>
> >>> Thanks
> >>>
> >>>
> >>>
> >>>> Thanks!
> >>>>
> >>>>> Thanks
> >>>>>
> >>>>>
> >>>>>> I think the reason why the feature bit is not checked in the code =
is
> >>>>>> because the check is omitted because it is on a per-packet basis,
> >>>>>> just like the reason why supported_valid_types is not needed as
> >>>>>> discussed in the v4 version threads. It is not unnecessary.
> >>>>>>
> >>>>>> Thanks!
> >>>>>>
> >>>>>>> If yes, why do we need to bother here? If we disable GUEST_CSUM, =
the
> >>>>>>> packet will contain checksum. And if the device sets DATA_VALID, =
it
> >>>>>>> means the checksum is validated.
> >>>>>>>
> >>>>>>> Thanks
> >>>>>>>
> >>>>>>>
> >>>>>>>
> >>>>>>>> Since Christmas is coming, I think this feature may be in danger=
 of
> >>>>>>>> following the pace of
> >>>>>>>> our hw version releases, so I sincerely request that you please =
review
> >>>>>>>> it as soon as possible.
> >>>>>>>>
> >>>>>>>> Thanks!
> >>>>>>>>
> >>>>>>>> =E5=9C=A8 2023/12/12 =E4=B8=8B=E5=8D=885:30, Heng Qi =E5=86=99=
=E9=81=93:
> >>>>>>>>> =E5=9C=A8 2023/12/12 =E4=B8=8B=E5=8D=885:23, Heng Qi =E5=86=99=
=E9=81=93:
> >>>>>>>>>> =E5=9C=A8 2023/12/12 =E4=B8=8B=E5=8D=884:44, Michael S. Tsirki=
n =E5=86=99=E9=81=93:
> >>>>>>>>>>> On Tue, Dec 12, 2023 at 11:28:21AM +0800, Heng Qi wrote:
> >>>>>>>>>>>> =E5=9C=A8 2023/12/12 =E4=B8=8A=E5=8D=8812:35, Michael S. Tsi=
rkin =E5=86=99=E9=81=93:
> >>>>>>>>>>>>> On Mon, Dec 11, 2023 at 05:11:59PM +0800, Heng Qi wrote:
> >>>>>>>>>>>>>> virtio-net works in a virtualized system and is somewhat
> >>>>>>>>>>>>>> different from
> >>>>>>>>>>>>>> physical nics. One of the differences is that to save virt=
io device
> >>>>>>>>>>>>>> resources, rx may receive partially checksummed packets. H=
owever,
> >>>>>>>>>>>>>> XDP may
> >>>>>>>>>>>>>> cause partially checksummed packets to be dropped.
> >>>>>>>>>>>>>> So XDP loading currently conflicts with the feature
> >>>>>>>>>>>>>> VIRTIO_NET_F_GUEST_CSUM.
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> This patch lets the device to supply fully checksummed pac=
kets to
> >>>>>>>>>>>>>> the driver.
> >>>>>>>>>>>>>> Then XDP can coexist with VIRTIO_NET_F_GUEST_CSUM to enjoy=
 the
> >>>>>>>>>>>>>> benefits of
> >>>>>>>>>>>>>> device validation checksum.
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> In addition, implementation of some performant devices alw=
ays do
> >>>>>>>>>>>>>> not generate
> >>>>>>>>>>>>>> partially checksummed packets, but the standard driver sti=
ll need
> >>>>>>>>>>>>>> to clear
> >>>>>>>>>>>>>> VIRTIO_NET_F_GUEST_CSUM when XDP is there.
> >>>>>>>>>>>>>> A new feature VIRTIO_NET_F_GUEST_FULLY_CSUM is added to so=
lve the
> >>>>>>>>>>>>>> above
> >>>>>>>>>>>>>> situation, which provides the driver with configurable off=
load.
> >>>>>>>>>>>>>> If the offload is enabled, then the device must deliver fu=
lly
> >>>>>>>>>>>>>> checksummed packets to the driver and may validate the che=
cksum.
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> Use case example:
> >>>>>>>>>>>>>> If VIRTIO_NET_F_GUEST_FULLY_CSUM is negotiated and the off=
load is
> >>>>>>>>>>>>>> enabled,
> >>>>>>>>>>>>>> after XDP processes a fully checksummed packet, the
> >>>>>>>>>>>>>> VIRTIO_NET_HDR_F_DATA_VALID bit
> >>>>>>>>>>>>>> is retained if the device has validated its checksum, resu=
lting
> >>>>>>>>>>>>>> in the guest
> >>>>>>>>>>>>>> not needing to validate the checksum again. This is useful=
 for
> >>>>>>>>>>>>>> guests:
> >>>>>>>>>>>>>>         1. Bring the driver advantages such as cpu savings=
.
> >>>>>>>>>>>>>>         2. For devices that do not generate partially chec=
ksummed
> >>>>>>>>>>>>>> packets themselves,
> >>>>>>>>>>>>>>            XDP can be loaded in the driver without modifyi=
ng the
> >>>>>>>>>>>>>> hardware behavior.
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> Several solutions have been discussed in the previous prop=
osal[1].
> >>>>>>>>>>>>>> After historical discussion, we have tried the method prop=
osed by
> >>>>>>>>>>>>>> Jason[2],
> >>>>>>>>>>>>>> but some complex scenarios and challenges are difficult to=
 deal
> >>>>>>>>>>>>>> with.
> >>>>>>>>>>>>>> We now return to the method suggested in [1].
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> [1]
> >>>>>>>>>>>>>> https://lists.oasis-open.org/archives/virtio-dev/202305/ms=
g00291.html
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> [2]
> >>>>>>>>>>>>>> https://lore.kernel.org/all/20230628030506.2213-1-hengqi@l=
inux.alibaba.com/
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
> >>>>>>>>>>>>>> Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> >>>>>>>>>>>>>> ---
> >>>>>>>>>>>>>> v4->v5:
> >>>>>>>>>>>>>> - Remove the modification to the GUEST_CSUM.
> >>>>>>>>>>>>>> - The description of this feature has been reorganized for
> >>>>>>>>>>>>>> greater clarity.
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> v3->v4:
> >>>>>>>>>>>>>> - Streamline some repetitive descriptions. @Jason
> >>>>>>>>>>>>>> - Add how features should work, when to be enabled, and ov=
erhead.
> >>>>>>>>>>>>>> @Jason @Michael
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> v2->v3:
> >>>>>>>>>>>>>> - Add a section named "Driver Handles Fully Checksummed Pa=
ckets"
> >>>>>>>>>>>>>>         and more descriptions. @Michael
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> v1->v2:
> >>>>>>>>>>>>>> - Modify full checksum functionality as a configurable off=
load
> >>>>>>>>>>>>>>         that is initially turned off. @Jason
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>>        device-types/net/description.tex        | 74
> >>>>>>>>>>>>>> +++++++++++++++++++++++--
> >>>>>>>>>>>>>>        device-types/net/device-conformance.tex |  1 +
> >>>>>>>>>>>>>>        device-types/net/driver-conformance.tex |  1 +
> >>>>>>>>>>>>>>        introduction.tex                        |  3 +
> >>>>>>>>>>>>>>        4 files changed, 73 insertions(+), 6 deletions(-)
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> diff --git a/device-types/net/description.tex
> >>>>>>>>>>>>>> b/device-types/net/description.tex
> >>>>>>>>>>>>>> index aff5e08..ab6c13d 100644
> >>>>>>>>>>>>>> --- a/device-types/net/description.tex
> >>>>>>>>>>>>>> +++ b/device-types/net/description.tex
> >>>>>>>>>>>>>> @@ -122,6 +122,9 @@ \subsection{Feature bits}\label{sec:De=
vice
> >>>>>>>>>>>>>> Types / Network Device / Feature bits
> >>>>>>>>>>>>>>            device with the same MAC address.
> >>>>>>>>>>>>>>        \item[VIRTIO_NET_F_SPEED_DUPLEX(63)] Device reports=
 speed and
> >>>>>>>>>>>>>> duplex.
> >>>>>>>>>>>>>> +
> >>>>>>>>>>>>>> +\item[VIRTIO_NET_F_GUEST_FULLY_CSUM (64)] Device delivers=
 fully
> >>>>>>>>>>>>>> checksummed packets
> >>>>>>>>>>>>>> +    to the driver and may validate the checksum.
> >>>>>>>>>>>>>>        \end{description}
> >>>>>>>>>>>>> I propose
> >>>>>>>>>>>>> VIRTIO_NET_F_GUEST_CSUM_COMPLETE
> >>>>>>>>>>>>> instead.
> >>>>>>>>>>>> Can I ask here if *complete* in VIRTIO_NET_F_GUEST_CSUM_COMP=
LETE and
> >>>>>>>>>>>> CHECKSUM_COMPLETE mean the same thing?
> >>>>>>>>>>>>
> >>>>>>>>>>>> If so, it seems that it's no longer the same as the descript=
ion of
> >>>>>>>>>>>> this
> >>>>>>>>>>>> patch.
> >>>>>>>>>>> Oh. I thought it is. Then I guess I misunderstand what this p=
atch is
> >>>>>>>>>>> supposed to be doing, again.
> >>>>>>>>>> Here's some context:
> >>>>>>>>>>
> >>>>>>>>>>     From the perspective of the Linux kernel, the GUEST_CSUM f=
eature is
> >>>>>>>>>> negotiated to support
> >>>>>>>>>> (1)  CHECKSUM_NONE, (2) CHECKSUM_UNNECESSARY, (3) CHECKSUM_PAR=
TIAL,
> >>>>>>>>>> which
> >>>>>>>>>> respectively correspond to (1) the device does not validate th=
e
> >>>>>>>>>> packet checksum (may not have
> >>>>>>>>>> the ability to validate some protocols or does not recognize t=
he
> >>>>>>>>>> packet); (2) the device has verified
> >>>>>>>>>> the data packet, then sets DATA_VALID bit in flags; (3) In ord=
er to
> >>>>>>>>>> save device resources, VMs
> >>>>>>>>>> on the same host deliver partially checksummed packets, and
> >>>>>>>>>> NEEDS_CSUM bit is set in flags.
> >>>>>>>>>>
> >>>>>>>>>> GUEST_FULLY_CSUM did not change the above result.
> >>>>>>>>> Sorry, GUEST_FULLY_CSUM prohibits the third(3) action.
> >>>>>>>>>
> >>>>>>>>>>>>>>        \subsubsection{Feature bit requirements}\label{sec:=
Device
> >>>>>>>>>>>>>> Types / Network Device / Feature bits / Feature bit requir=
ements}
> >>>>>>>>>>>>>> @@ -136,6 +139,7 @@ \subsubsection{Feature bit
> >>>>>>>>>>>>>> requirements}\label{sec:Device Types / Network Device
> >>>>>>>>>>>>>>        \item[VIRTIO_NET_F_GUEST_UFO] Requires VIRTIO_NET_F=
_GUEST_CSUM.
> >>>>>>>>>>>>>>        \item[VIRTIO_NET_F_GUEST_USO4] Requires VIRTIO_NET_=
F_GUEST_CSUM.
> >>>>>>>>>>>>>>        \item[VIRTIO_NET_F_GUEST_USO6] Requires VIRTIO_NET_=
F_GUEST_CSUM.
> >>>>>>>>>>>>>> +\item[VIRTIO_NET_F_GUEST_FULLY_CSUM] Requires
> >>>>>>>>>>>>>> VIRTIO_NET_F_GUEST_CSUM and VIRTIO_NET_F_CTRL_GUEST_OFFLOA=
DS.
> >>>>>>>>>>>>>>        \item[VIRTIO_NET_F_HOST_TSO4] Requires VIRTIO_NET_F=
_CSUM.
> >>>>>>>>>>>>>>        \item[VIRTIO_NET_F_HOST_TSO6] Requires VIRTIO_NET_F=
_CSUM.
> >>>>>>>>>>>>>> @@ -398,6 +402,58 @@ \subsection{Device
> >>>>>>>>>>>>>> Initialization}\label{sec:Device Types / Network Device / =
Dev
> >>>>>>>>>>>>>>        A truly minimal driver would only accept VIRTIO_NET=
_F_MAC and
> >>>>>>>>>>>>>> ignore
> >>>>>>>>>>>>>>        everything else.
> >>>>>>>>>>>>>> +\subsubsection{Device Delivers Fully Checksummed
> >>>>>>>>>>>>>> Packets}\label{sec:Device Types / Network Device / Device
> >>>>>>>>>>>>>> Initialization / Device Delivers Fully Checksummed Packets=
}
> >>>>>>>>>>>>>> +
> >>>>>>>>>>>>>> +If the feature VIRTIO_NET_F_GUEST_FULLY_CSUM is negotiate=
d, the
> >>>>>>>>>>>>>> driver can
> >>>>>>>>>>>>>> +benefit from the device's ability to calculate and valida=
te the
> >>>>>>>>>>>>>> checksum.
> >>>>>>>>>>>>>> +
> >>>>>>>>>>>>>> +If the feature VIRTIO_NET_F_GUEST_FULLY_CSUM is negotiate=
d,
> >>>>>>>>>>>>>> +the device behaves as follows:
> >>>>>>>>>>>>>> +\begin{itemize}
> >>>>>>>>>>>>>> +  \item The device delivers a fully checksummed packet to=
 the
> >>>>>>>>>>>>>> driver rather than a partially checksummed packet.
> >>>>>>>>>>>>> where does "partially checksummed packet" come from?
> >>>>>>>>>>>>> I think it comes from:
> >>>>>>>>>>>> Yes, you are right.
> >>>>>>>>>>>>
> >>>>>>>>>>>>>          The VIRTIO_NET_F_GUEST_CSUM feature indicates that=
 partially
> >>>>>>>>>>>>>         checksummed packets can be received, and if it can =
do that then
> >>>>>>>>>>>>>         the VIRTIO_NET_F_GUEST_TSO4, VIRTIO_NET_F_GUEST_TSO=
6,
> >>>>>>>>>>>>>         VIRTIO_NET_F_GUEST_UFO, VIRTIO_NET_F_GUEST_ECN,
> >>>>>>>>>>>>> VIRTIO_NET_F_GUEST_USO4
> >>>>>>>>>>>>>         and VIRTIO_NET_F_GUEST_USO6 are the input equivalen=
ts of the
> >>>>>>>>>>>>> features described above.
> >>>>>>>>>>>>>         See \ref{sec:Device Types / Network Device / Device=
 Operation /
> >>>>>>>>>>>>>
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> so that one needs to be updated too.
> >>>>>>>>>>>> Will update this.
> >>>>>>>>>>>>
> >>>>>>>>>>>>>> +Partially checksummed packets come from TCP/UDP protocols
> >>>>>>>>>>>>>> \ref{devicenormative:Device Types / Network Device / Devic=
e
> >>>>>>>>>>>>>> Operation / Processing of Packets}.
> >>>>>>>>>>>>>> +  \item The device may validate the packet checksum befor=
e
> >>>>>>>>>>>>>> delivering it.
> >>>>>>>>>>>>>> +If the packet checksum has been verified, the
> >>>>>>>>>>>>>> VIRTIO_NET_HDR_F_DATA_VALID bit
> >>>>>>>>>>>>>> +in \field{flags} is set: in case of multiple encapsulated
> >>>>>>>>>>>>>> protocols, one
> >>>>>>>>>>>>>> +level of checksums has been validated (Just like
> >>>>>>>>>>>>>> VIRTIO_NET_F_GUEST_CSUM does.).
> >>>>>>>>>>>>>> +  \item The device can not set the VIRTIO_NET_HDR_F_NEEDS=
_CSUM
> >>>>>>>>>>>>>> bit in \field{flags}.
> >>>>>>>>>>>>>> +\end{itemize}
> >>>>>>>>>>>>>> +
> >>>>>>>>>>>>>> +Note that packet types that the driver or device can reco=
gnize
> >>>>>>>>>>>>>> and the device
> >>>>>>>>>>>>>> +may verify will not change due to the additional negotiat=
ed
> >>>>>>>>>>>>>> VIRTIO_NET_F_GUEST_FULLY_CSUM.
> >>>>>>>>>>>>>> +These remain consistent with VIRTIO_NET_F_GUEST_CSUM.
> >>>>>>>>>>>>> This part is confusing. "change" and "remain" makes no sens=
e for
> >>>>>>>>>>>>> someone reading
> >>>>>>>>>>>>> the spec text as opposed to reviewing the patch.
> >>>>>>>>>>>>> also it does not matter whether VIRTIO_NET_F_GUEST_FULLY_CS=
UM
> >>>>>>>>>>>>> is negotiated right? it only matters whether it is enabled.
> >>>>>>>>>>>> Right! And following your suggestion, I plan to rewrite it a=
s follows:
> >>>>>>>>>>>>
> >>>>>>>>>>>> Note that if VIRTIO_NET_F_GUEST_FULLY_CSUM is additionally
> >>>>>>>>>>>> negotiated and
> >>>>>>>>>>>> its offload is enabled, packet types that the driver or devi=
ce can
> >>>>>>>>>>>> recognize
> >>>>>>>>>>>> and the
> >>>>>>>>>>>> device may verify are consistent with when VIRTIO_NET_F_GUES=
T_CSUM is
> >>>>>>>>>>>> negotiated.
> >>>>>>>>>>> This doesn't really clarify.  If you'd like it put more simpl=
y: Never
> >>>>>>>>>>> imagine yourself not to be otherwise than what it might appea=
r to
> >>>>>>>>>>> others
> >>>>>>>>>>> that what you were or might have been was not otherwise than =
what you
> >>>>>>>>>>> had been would have appeared to them to be otherwise.
> >>>>>>>>>> Sorry, I'm not a native speaker and didn't quite understand th=
is long
> >>>>>>>>>> sentence.
> >>>>>>>>>> But I think you suggest that I should not explain something fr=
om the
> >>>>>>>>>> perspective
> >>>>>>>>>> of someone who is already familiar with it, but should try to =
explain
> >>>>>>>>>> it clearly
> >>>>>>>>>> for readers who are not familiar with it.
> >>>>>>>>>>
> >>>>>>>>>> I'll try to explain it more clearly.
> >>>>>>>>>>
> >>>>>>>>>>>>>> +Specific transport protocols that may have
> >>>>>>>>>>>>>> VIRTIO_NET_HDR_F_DATA_VALID set
> >>>>>>>>>>>>>> +in \field{flags} include TCP, UDP, GRE (Generic Routing
> >>>>>>>>>>>>>> Encapsulation),
> >>>>>>>>>>>>>> +and SCTP (Stream Control Transmission Protocol).
> >>>>>>>>>>>>>> +A fully checksummed packet's checksum field for each of t=
he
> >>>>>>>>>>>>>> above protocols
> >>>>>>>>>>>>>> +is set to a calculated value that covers the transport he=
ader
> >>>>>>>>>>>>>> and payload
> >>>>>>>>>>>>>> +(TCP or UDP involves the additional pseudo header) of the=
 packet.
> >>>>>>>>>>>>>> +
> >>>>>>>>>>>>>> +Delivering fully checksummed packets rather than partiall=
y
> >>>>>>>>>>>>>> +checksummed packets incurs additional overhead for the de=
vice.
> >>>>>>>>>>>>>> +The overhead varies from device to device, for example th=
e
> >>>>>>>>>>>>>> overhead of
> >>>>>>>>>>>>>> +calculating and validating the packet checksum is a few
> >>>>>>>>>>>>>> microseconds
> >>>>>>>>>>>>>> +for a hardware device.
> >>>>>>>>>>>>> wow really is that standard? There are devices that deliver=
 the whole
> >>>>>>>>>>>>> packet in a few microseconds. Maybe "for some hardware devi=
ces"?
> >>>>>>>>>>>> Ok, I think it's more accurate.
> >>>>>>>>>>>>
> >>>>>>>>>>>>>> +
> >>>>>>>>>>>>>> +The feature VIRTIO_NET_F_GUEST_FULLY_CSUM has a correspon=
ding
> >>>>>>>>>>>>>> offload \ref{sec:Device Types / Network Device / Device Op=
eration
> >>>>>>>>>>>>>> / Control Virtqueue / Offloads State Configuration},
> >>>>>>>>>>>>>> +which when enabled means that the device delivers fully
> >>>>>>>>>>>>>> checksummed packets
> >>>>>>>>>>>>>> +to the driver and may validate the checksum.
> >>>>>>>>>>>>>> +The offload is disabled by default.
> >>>>>>>>>>>>> This is unusual, unlike any other offload. So needs to be s=
tressed
> >>>>>>>>>>>>> more.  And what does "default" mean here?
> >>>>>>>>>>>>> E.g. "Note: unlike other offloads, this offloads is disable=
d
> >>>>>>>>>>>>> even after VIRTIO_NET_F_GUEST_FULLY_CSUM has been negotiati=
on.
> >>>>>>>>>>>> Ok. Will rewrite this following your example.
> >>>>>>>>>>>>
> >>>>>>>>>>>>> The offload has to be enabled ... "
> >>>>>>>>>>>>>
> >>>>>>>>>>>>>
> >>>>>>>>>>>>>> +
> >>>>>>>>>>>>>> +The driver can enable the offload by sending the
> >>>>>>>>>>>>>> +VIRTIO_NET_CTRL_GUEST_OFFLOADS_SET command with the
> >>>>>>>>>>>>>> +VIRTIO_NET_F_GUEST_FULLY_CSUM bit set when, for example,
> >>>>>>>>>>>>>> +eXpress Data Path (XDP) \hyperref[intro:xdp]{[XDP]} is fu=
nctioning.
> >>>>>>>>>>>>> It is not worth adding a spec link just to provide an examp=
le.
> >>>>>>>>>>>>> If you really want to provide it:
> >>>>>>>>>>>>> "eXpress Data Path (XDP) in Linux is active".
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> But this is the problem this patch does not solve in my opi=
nion.
> >>>>>>>>>>>>> A device might actually provide a full checksum
> >>>>>>>>>>>>> at negligeable extra cost and driver will still keep it off=
 by
> >>>>>>>>>>>>> default.
> >>>>>>>>>>>>> So it slows device down - when does it make sense to enable=
 this
> >>>>>>>>>>>>> feature?
> >>>>>>>>>>>>> Just giving an example of XDP is not sufficient.
> >>>>>>>>>>>> First of all, I think the core purpose of this patch is to s=
upport XDP
> >>>>>>>>>>>> loading.
> >>>>>>>>>>>> Otherwise, I think GUEST_CSUM works just fine.
> >>>>>>>>>>>>
> >>>>>>>>>>>> 1. The device is performant, even if only GUEST_CSUM is nego=
tiated,
> >>>>>>>>>>>> the
> >>>>>>>>>>>> device only provide fully checksummed packets.
> >>>>>>>>>>>> If the offload of GUEST_FULLY_CSUM is disabled, it is equiva=
lent to
> >>>>>>>>>>>> only
> >>>>>>>>>>>> GUEST_CSUM working, and the device still
> >>>>>>>>>>>> provides fully checksummed packets. This will not slow the d=
evice
> >>>>>>>>>>>> down.
> >>>>>>>>>>>>
> >>>>>>>>>>>> 2. For example a sw device. If the device only negotiates
> >>>>>>>>>>>> GUEST_CSUM, it may
> >>>>>>>>>>>> provide partially checksummed packets.
> >>>>>>>>>>>> In the absence of XDP loading requirements, the driver does =
not
> >>>>>>>>>>>> need to
> >>>>>>>>>>>> enable GUEST_FULLY_CSUM offload.
> >>>>>>>>>>> Well first of all I am no longer even sure what this GUEST_FU=
LLY_CSUM
> >>>>>>>>>>> does. I thought it is CHECKSUM_COMPLETE.
> >>>>>>>>>>> But more generally, is there an assumption driver will not
> >>>>>>>>>>> enable this new checksum typically then? Unless what? If we n=
ever
> >>>>>>>>>>> tell drivers they should not enable it they will, the
> >>>>>>>>>>> fact that it's off by default seems to be a hint that it
> >>>>>>>>>>> is typically a bad idea to enable it. But when is it a good i=
dea?
> >>>>>>>>>> I think the core difference between GUEST_FULLY_CSUM and GUEST=
_CSUM
> >>>>>>>>>> is that
> >>>>>>>>>> GUEST_CSUM may generate partially checksummed TCP/UDP packets,
> >>>>>>>>>> causing xdp to fail to load.
> >>>>>>>>>> GUEST_FULLY_CSUM forces fully checksummed TCP/UDP packets to b=
e
> >>>>>>>>>> generated so xdp can load.
> >>>>>>>>>> For the rest, I guess there is no difference between GUEST_FUL=
LY_CSUM
> >>>>>>>>>> and GUEST_CSUM.
> >>>>>>>>>>
> >>>>>>>>>> As for when the driver enables the offload, I think I have alr=
eady
> >>>>>>>>>> mentioned:
> >>>>>>>>>> Enable this offload in the interface where XDP is loaded,
> >>>>>>>>>> Disable this offload in the interfaces where XDP is unloaded.
> >>>>>>>>>>
> >>>>>>>>>> Thanks=EF=BC=81
> >>>>>>>>>>
> >>>>>>>>>>>>>> +
> >>>>>>>>>>>>>> +\drivernormative{\subsubsection}{Device Delivers Fully
> >>>>>>>>>>>>>> Checksummed Packets}{sec:Device Types / Network Device / D=
evice
> >>>>>>>>>>>>>> Initialization / Device Delivers Fully Checksummed Packets=
}
> >>>>>>>>>>>>>> +
> >>>>>>>>>>>>>> +The driver MUST NOT enable the offload for which
> >>>>>>>>>>>>>> VIRTIO_NET_F_GUEST_FULLY_CSUM has not been negotiated.
> >>>>>>>>>>>>> what does "the offload for which" mean here?
> >>>>>>>>>>>> VIRTIO_NET_F_GUEST_FULLY_CSUM's offload
> >>>>>>>>>>>>
> >>>>>>>>>>>>> and how is this special for VIRTIO_NET_F_GUEST_FULLY_CSUM?
> >>>>>>>>>>>> Well, I think this sentence seems a bit redundant and I'll p=
robably
> >>>>>>>>>>>> remove
> >>>>>>>>>>>> this.
> >>>>>>>>>>>>
> >>>>>>>>>>>>>> +\devicenormative{\subsubsection}{Device Delivers Fully
> >>>>>>>>>>>>>> Checksummed Packets}{sec:Device Types / Network Device / D=
evice
> >>>>>>>>>>>>>> Initialization / Device Delivers Fully Checksummed Packets=
}
> >>>>>>>>>>>>>> +
> >>>>>>>>>>>>>> +Upon the device reset, the device MUST disable the offloa=
d.
> >>>>>>>>>>>>>> +
> >>>>>>>>>>>>> reset has nothing to do with it I think. it's about feature
> >>>>>>>>>>>>> negotiation.
> >>>>>>>>>>>> Will modify this.
> >>>>>>>>>>>>
> >>>>>>>>>>>> Thanks a lot!
> >>>>>>>>>>>>
> >>>>>>>>>>>>>>        \subsection{Device Operation}\label{sec:Device Type=
s / Network
> >>>>>>>>>>>>>> Device / Device Operation}
> >>>>>>>>>>>>>>        Packets are transmitted by placing them in the
> >>>>>>>>>>>>>> @@ -723,7 +779,8 @@ \subsubsection{Processing of Incoming
> >>>>>>>>>>>>>> Packets}\label{sec:Device Types / Network
> >>>>>>>>>>>>>>          \field{num_buffers} is one, then the entire packe=
t will be
> >>>>>>>>>>>>>>          contained within this buffer, immediately followi=
ng the struct
> >>>>>>>>>>>>>>          virtio_net_hdr.
> >>>>>>>>>>>>>> -\item If the VIRTIO_NET_F_GUEST_CSUM feature was negotiat=
ed, the
> >>>>>>>>>>>>>> +\item If the VIRTIO_NET_F_GUEST_CSUM feature (regardless =
of whether
> >>>>>>>>>>>>>> +  VIRTIO_NET_F_GUEST_FULLY_CSUM was negotiated) was negot=
iated, the
> >>>>>>>>>>>>>>          VIRTIO_NET_HDR_F_DATA_VALID bit in \field{flags} =
can be
> >>>>>>>>>>>>>>          set: if so, device has validated the packet check=
sum.
> >>>>>>>>>>>>>>          In case of multiple encapsulated protocols, one l=
evel of
> >>>>>>>>>>>>>> checksums
> >>>>>>>>>>>>>> @@ -747,7 +804,8 @@ \subsubsection{Processing of Incoming
> >>>>>>>>>>>>>> Packets}\label{sec:Device Types / Network
> >>>>>>>>>>>>>>          number of coalesced TCP segments in \field{csum_s=
tart} field
> >>>>>>>>>>>>>> and
> >>>>>>>>>>>>>>          number of duplicated ACK segments in \field{csum_=
offset} field
> >>>>>>>>>>>>>>          and sets bit VIRTIO_NET_HDR_F_RSC_INFO in \field{=
flags}.
> >>>>>>>>>>>>>> -\item If the VIRTIO_NET_F_GUEST_CSUM feature was negotiat=
ed, the
> >>>>>>>>>>>>>> +\item If the VIRTIO_NET_F_GUEST_CSUM feature was negotiat=
ed but the
> >>>>>>>>>>>>>> +  VIRTIO_NET_F_GUEST_FULLY_CSUM feature was not negotiate=
d, the
> >>>>>>>>>>>>>>          VIRTIO_NET_HDR_F_NEEDS_CSUM bit in \field{flags} =
can be
> >>>>>>>>>>>>>>          set: if so, the packet checksum at offset \field{=
csum_offset}
> >>>>>>>>>>>>>>          from \field{csum_start} and any preceding checksu=
ms
> >>>>>>>>>>>>>> @@ -805,8 +863,9 @@ \subsubsection{Processing of Incoming
> >>>>>>>>>>>>>> Packets}\label{sec:Device Types / Network
> >>>>>>>>>>>>>>        device MUST set the VIRTIO_NET_HDR_GSO_ECN bit in
> >>>>>>>>>>>>>>        \field{gso_type}.
> >>>>>>>>>>>>>> -If the VIRTIO_NET_F_GUEST_CSUM feature has been negotiate=
d, the
> >>>>>>>>>>>>>> -device MAY set the VIRTIO_NET_HDR_F_NEEDS_CSUM bit in
> >>>>>>>>>>>>>> +If the VIRTIO_NET_F_GUEST_CSUM feature has been negotiate=
d but
> >>>>>>>>>>>>>> +the VIRTIO_NET_F_GUEST_FULLY_CSUM feature has not been ne=
gotiated,
> >>>>>>>>>>>>>> +the device MAY set the VIRTIO_NET_HDR_F_NEEDS_CSUM bit in
> >>>>>>>>>>>>>>        \field{flags}, if so:
> >>>>>>>>>>>>>>        \begin{enumerate}
> >>>>>>>>>>>>>>        \item the device MUST validate the packet checksum =
at
> >>>>>>>>>>>>>> @@ -826,7 +885,8 @@ \subsubsection{Processing of Incoming
> >>>>>>>>>>>>>> Packets}\label{sec:Device Types / Network
> >>>>>>>>>>>>>>        been negotiated, the device MUST set \field{gso_typ=
e} to
> >>>>>>>>>>>>>>        VIRTIO_NET_HDR_GSO_NONE.
> >>>>>>>>>>>>>> -If \field{gso_type} differs from VIRTIO_NET_HDR_GSO_NONE,=
 then
> >>>>>>>>>>>>>> +If the VIRTIO_NET_F_GUEST_FULLY_CSUM feature has not been
> >>>>>>>>>>>>>> negotiated and
> >>>>>>>>>>>>>> +\field{gso_type} differs from VIRTIO_NET_HDR_GSO_NONE, th=
en
> >>>>>>>>>>>>>>        the device MUST also set the VIRTIO_NET_HDR_F_NEEDS=
_CSUM bit in
> >>>>>>>>>>>>>>        \field{flags} MUST set \field{gso_size} to indicate=
 the
> >>>>>>>>>>>>>> desired MSS.
> >>>>>>>>>>>>>>        If VIRTIO_NET_F_RSC_EXT was negotiated, the device =
MUST also
> >>>>>>>>>>>>>> @@ -842,7 +902,8 @@ \subsubsection{Processing of Incoming
> >>>>>>>>>>>>>> Packets}\label{sec:Device Types / Network
> >>>>>>>>>>>>>>        not less than the length of the headers, including =
the transport
> >>>>>>>>>>>>>>        header.
> >>>>>>>>>>>>>> -If the VIRTIO_NET_F_GUEST_CSUM feature has been negotiate=
d, the
> >>>>>>>>>>>>>> +If the VIRTIO_NET_F_GUEST_CSUM feature (regardless of whe=
ther
> >>>>>>>>>>>>>> +VIRTIO_NET_F_GUEST_FULLY_CSUM has been negotiated) has be=
en
> >>>>>>>>>>>>>> negotiated, the
> >>>>>>>>>>>>>>        device MAY set the VIRTIO_NET_HDR_F_DATA_VALID bit =
in
> >>>>>>>>>>>>>>        \field{flags}, if so, the device MUST validate the =
packet
> >>>>>>>>>>>>>>        checksum (in case of multiple encapsulated protocol=
s, one level
> >>>>>>>>>>>>>> @@ -1633,6 +1694,7 @@ \subsubsection{Control
> >>>>>>>>>>>>>> Virtqueue}\label{sec:Device Types / Network Device / Devi
> >>>>>>>>>>>>>>        #define VIRTIO_NET_F_GUEST_UFO        10
> >>>>>>>>>>>>>>        #define VIRTIO_NET_F_GUEST_USO4       54
> >>>>>>>>>>>>>>        #define VIRTIO_NET_F_GUEST_USO6       55
> >>>>>>>>>>>>>> +#define VIRTIO_NET_F_GUEST_FULLY_CSUM 64
> >>>>>>>>>>>>>>        #define VIRTIO_NET_CTRL_GUEST_OFFLOADS       5
> >>>>>>>>>>>>>>         #define VIRTIO_NET_CTRL_GUEST_OFFLOADS_SET   0
> >>>>>>>>>>>>>> diff --git a/device-types/net/device-conformance.tex
> >>>>>>>>>>>>>> b/device-types/net/device-conformance.tex
> >>>>>>>>>>>>>> index 52526e4..43b3921 100644
> >>>>>>>>>>>>>> --- a/device-types/net/device-conformance.tex
> >>>>>>>>>>>>>> +++ b/device-types/net/device-conformance.tex
> >>>>>>>>>>>>>> @@ -16,4 +16,5 @@
> >>>>>>>>>>>>>>        \item \ref{devicenormative:Device Types / Network D=
evice /
> >>>>>>>>>>>>>> Device Operation / Control Virtqueue / Notifications Coale=
scing}
> >>>>>>>>>>>>>>        \item \ref{devicenormative:Device Types / Network D=
evice /
> >>>>>>>>>>>>>> Device Operation / Control Virtqueue / Inner Header Hash}
> >>>>>>>>>>>>>>        \item \ref{devicenormative:Device Types / Network D=
evice /
> >>>>>>>>>>>>>> Device Operation / Control Virtqueue / Device Statistics}
> >>>>>>>>>>>>>> +\item \ref{devicenormative:Device Types / Network Device =
/
> >>>>>>>>>>>>>> Device Initialization / Device Delivers Fully Checksummed =
Packets}
> >>>>>>>>>>>>>>        \end{itemize}
> >>>>>>>>>>>>>> diff --git a/device-types/net/driver-conformance.tex
> >>>>>>>>>>>>>> b/device-types/net/driver-conformance.tex
> >>>>>>>>>>>>>> index c693c4f..c9b6d1b 100644
> >>>>>>>>>>>>>> --- a/device-types/net/driver-conformance.tex
> >>>>>>>>>>>>>> +++ b/device-types/net/driver-conformance.tex
> >>>>>>>>>>>>>> @@ -16,4 +16,5 @@
> >>>>>>>>>>>>>>        \item \ref{drivernormative:Device Types / Network D=
evice /
> >>>>>>>>>>>>>> Device Operation / Control Virtqueue / Notifications Coale=
scing}
> >>>>>>>>>>>>>>        \item \ref{drivernormative:Device Types / Network D=
evice /
> >>>>>>>>>>>>>> Device Operation / Control Virtqueue / Inner Header Hash}
> >>>>>>>>>>>>>>        \item \ref{drivernormative:Device Types / Network D=
evice /
> >>>>>>>>>>>>>> Device Operation / Control Virtqueue / Device Statistics}
> >>>>>>>>>>>>>> +\item \ref{drivernormative:Device Types / Network Device =
/
> >>>>>>>>>>>>>> Device Initialization / Device Delivers Fully Checksummed =
Packets}
> >>>>>>>>>>>>>>        \end{itemize}
> >>>>>>>>>>>>>> diff --git a/introduction.tex b/introduction.tex
> >>>>>>>>>>>>>> index cfa6633..fc99597 100644
> >>>>>>>>>>>>>> --- a/introduction.tex
> >>>>>>>>>>>>>> +++ b/introduction.tex
> >>>>>>>>>>>>>> @@ -145,6 +145,9 @@ \section{Normative
> >>>>>>>>>>>>>> References}\label{sec:Normative References}
> >>>>>>>>>>>>>>            Leiba, B., "Ambiguity of Uppercase vs Lowercase=
 in RFC
> >>>>>>>>>>>>>> 2119 Key Words", BCP
> >>>>>>>>>>>>>>            14, RFC 8174, DOI 10.17487/RFC8174, May 2017
> >>>>>>>>>>>>>> \newline\url{http://www.ietf.org/rfc/rfc8174.txt}\\
> >>>>>>>>>>>>>> +    \phantomsection\label{intro:xdp}\textbf{[XDP]} &
> >>>>>>>>>>>>>> +    eXpress Data Path(XDP) provides a high performance,
> >>>>>>>>>>>>>> programmable network data path in the Linux kernel.
> >>>>>>>>>>>>>> +
> >>>>>>>>>>>>>> \newline\url{https://prototype-kernel.readthedocs.io/en/la=
test/networking/XDP/}\\
> >>>>>>>>>>>>>>        \end{longtable}
> >>>>>>>>>>>>>>        \section{Non-Normative References}
> >>>>>>>>>>>>>> --
> >>>>>>>>>>>>>> 2.19.1.6.gb485710b
> >>>>>>>>>>> This publicly archived list offers a means to provide input t=
o the
> >>>>>>>>>>> OASIS Virtual I/O Device (VIRTIO) TC.
> >>>>>>>>>>>
> >>>>>>>>>>> In order to verify user consent to the Feedback License terms=
 and
> >>>>>>>>>>> to minimize spam in the list archive, subscription is require=
d
> >>>>>>>>>>> before posting.
> >>>>>>>>>>>
> >>>>>>>>>>> Subscribe: virtio-comment-subscribe@lists.oasis-open.org
> >>>>>>>>>>> Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
> >>>>>>>>>>> List help: virtio-comment-help@lists.oasis-open.org
> >>>>>>>>>>> List archive: https://lists.oasis-open.org/archives/virtio-co=
mment/
> >>>>>>>>>>> Feedback License:
> >>>>>>>>>>> https://www.oasis-open.org/who/ipr/feedback_license.pdf
> >>>>>>>>>>> List Guidelines:
> >>>>>>>>>>> https://www.oasis-open.org/policies-guidelines/mailing-lists
> >>>>>>>>>>> Committee: https://www.oasis-open.org/committees/virtio/
> >>>>>>>>>>> Join OASIS: https://www.oasis-open.org/join/
> >>>>>>>>>> This publicly archived list offers a means to provide input to=
 the
> >>>>>>>>>> OASIS Virtual I/O Device (VIRTIO) TC.
> >>>>>>>>>>
> >>>>>>>>>> In order to verify user consent to the Feedback License terms =
and
> >>>>>>>>>> to minimize spam in the list archive, subscription is required
> >>>>>>>>>> before posting.
> >>>>>>>>>>
> >>>>>>>>>> Subscribe: virtio-comment-subscribe@lists.oasis-open.org
> >>>>>>>>>> Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
> >>>>>>>>>> List help: virtio-comment-help@lists.oasis-open.org
> >>>>>>>>>> List archive: https://lists.oasis-open.org/archives/virtio-com=
ment/
> >>>>>>>>>> Feedback License:
> >>>>>>>>>> https://www.oasis-open.org/who/ipr/feedback_license.pdf
> >>>>>>>>>> List Guidelines:
> >>>>>>>>>> https://www.oasis-open.org/policies-guidelines/mailing-lists
> >>>>>>>>>> Committee: https://www.oasis-open.org/committees/virtio/
> >>>>>>>>>> Join OASIS: https://www.oasis-open.org/join/
> >>>>>>>>> This publicly archived list offers a means to provide input to =
the
> >>>>>>>>> OASIS Virtual I/O Device (VIRTIO) TC.
> >>>>>>>>>
> >>>>>>>>> In order to verify user consent to the Feedback License terms a=
nd
> >>>>>>>>> to minimize spam in the list archive, subscription is required
> >>>>>>>>> before posting.
> >>>>>>>>>
> >>>>>>>>> Subscribe: virtio-comment-subscribe@lists.oasis-open.org
> >>>>>>>>> Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
> >>>>>>>>> List help: virtio-comment-help@lists.oasis-open.org
> >>>>>>>>> List archive: https://lists.oasis-open.org/archives/virtio-comm=
ent/
> >>>>>>>>> Feedback License: https://www.oasis-open.org/who/ipr/feedback_l=
icense.pdf
> >>>>>>>>> List Guidelines:
> >>>>>>>>> https://www.oasis-open.org/policies-guidelines/mailing-lists
> >>>>>>>>> Committee: https://www.oasis-open.org/committees/virtio/
> >>>>>>>>> Join OASIS: https://www.oasis-open.org/join/
> >>>>>>> This publicly archived list offers a means to provide input to th=
e
> >>>>>>> OASIS Virtual I/O Device (VIRTIO) TC.
> >>>>>>>
> >>>>>>> In order to verify user consent to the Feedback License terms and
> >>>>>>> to minimize spam in the list archive, subscription is required
> >>>>>>> before posting.
> >>>>>>>
> >>>>>>> Subscribe: virtio-comment-subscribe@lists.oasis-open.org
> >>>>>>> Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
> >>>>>>> List help: virtio-comment-help@lists.oasis-open.org
> >>>>>>> List archive: https://lists.oasis-open.org/archives/virtio-commen=
t/
> >>>>>>> Feedback License: https://www.oasis-open.org/who/ipr/feedback_lic=
ense.pdf
> >>>>>>> List Guidelines: https://www.oasis-open.org/policies-guidelines/m=
ailing-lists
> >>>>>>> Committee: https://www.oasis-open.org/committees/virtio/
> >>>>>>> Join OASIS: https://www.oasis-open.org/join/
> >>>>> -------------------------------------------------------------------=
--
> >>>>> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> >>>>> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.o=
rg
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
> >>> List Guidelines: https://www.oasis-open.org/policies-guidelines/maili=
ng-lists
> >>> Committee: https://www.oasis-open.org/committees/virtio/
> >>> Join OASIS: https://www.oasis-open.org/join/
> >
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

