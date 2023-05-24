Return-Path: <virtio-dev-return-12802-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A539BC77B7C
	for <virtio-dev@archiver.kernel.org>; Wed, 24 May 2023 05:52:48 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id B99D5179172
	for <virtio-dev@archiver.kernel.org>; Wed, 24 May 2023 05:52:47 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id ABBC898641E
	for <virtio-dev@archiver.kernel.org>; Wed, 24 May 2023 05:52:47 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 9BE85986412; Wed, 24 May 2023 05:52:47 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 87DAD986406
	for <virtio-dev@lists.oasis-open.org>; Wed, 24 May 2023 05:52:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: OcMtKEIhMzigJDS6YzIQEw-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684907562; x=1687499562;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZhNHV/Gywnvg0fB/UvNslIdhONLd+tr32H0zcvniSZI=;
        b=Prh6XUThXZ9NkU1It2wu4IMGjLxQm6Q+yUiB949Ou8yi8qN1MvozjmzFZdNNnEa8kd
         oYE0eDmEYsjceZ+0EOp5qI4rZBCQFfwfdCTKEbQx0b0zR6ISrwZUNnfvUBD7q/ssebdG
         LUDvJ4US3GQM1tkZnUy2KlI49rBPhKYfolMPlkKCsKE7z8NN5RHCCIsQUnyy35KmdsTw
         Xuc5OygOXHsJOAbFd6NH/1vT/8dGqYZkrF1xHyK8njnPPxo1QTbcyrtI3MOxUCFO7sIp
         8qIgiBjfTac/uZj1TtWYbYhXOTMl6sotJYP4brb316XRuRPkT4NMxyQtSfFRqZRBp+4m
         Dx4Q==
X-Gm-Message-State: AC+VfDx7QXwpHltdVTBLjQdl+en2DEKkLdXEm7yRESWsB3dXosIkND/Z
	eog+gUYQbaud2nlWrjBYZrQhLlQPoxHEfEJLVavih3lBRgGnwRLPg+kdnxWegHMumzjg2zQL8ot
	1oCaXSAjOgx9WR5iVRqVvlBkL/01y6y88V/G4SAvhyt1+
X-Received: by 2002:a2e:9990:0:b0:2af:2e68:9f96 with SMTP id w16-20020a2e9990000000b002af2e689f96mr4071305lji.8.1684907561902;
        Tue, 23 May 2023 22:52:41 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5nk9pzRKeBu5ZizCATnximffg8+gwk0kKnNGSbaja/19rFUdiXad34DI285fB0gKvg/ZkAI/eN0ztffEHwGHA=
X-Received: by 2002:a2e:9990:0:b0:2af:2e68:9f96 with SMTP id
 w16-20020a2e9990000000b002af2e689f96mr4071298lji.8.1684907561535; Tue, 23 May
 2023 22:52:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230522121200.40939-1-hengqi@linux.alibaba.com>
 <20230522150743-mutt-send-email-mst@kernel.org> <20230523024118.GA23504@h68b04307.sqa.eu95>
 <20230523024057-mutt-send-email-mst@kernel.org> <20230523091820.GC23504@h68b04307.sqa.eu95>
 <20230523092237-mutt-send-email-mst@kernel.org> <20230523135144.GD23504@h68b04307.sqa.eu95>
 <CACGkMEscLOVssyAeTYZE0o_KT86UazdBdj9NKPrmK5=g6YcBuA@mail.gmail.com> <20230524050723.GA93898@h68b04307.sqa.eu95>
In-Reply-To: <20230524050723.GA93898@h68b04307.sqa.eu95>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 24 May 2023 13:52:30 +0800
Message-ID: <CACGkMEv=OK3w6_uHhaOv8TjtMVpgkHG0Ba-+OWd1KN=17V8p9g@mail.gmail.com>
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, virtio-dev@lists.oasis-open.org, 
	virtio-comment@lists.oasis-open.org, Parav Pandit <parav@nvidia.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [virtio-dev] Re: [virtio-comment] Re: [virtio-dev] Re: [Proposal] Relationship
 between XDP and rx-csum in virtio-nety

On Wed, May 24, 2023 at 1:07=E2=80=AFPM Heng Qi <hengqi@linux.alibaba.com> =
wrote:
>
> On Wed, May 24, 2023 at 12:09:22PM +0800, Jason Wang wrote:
> > On Tue, May 23, 2023 at 9:51=E2=80=AFPM Heng Qi <hengqi@linux.alibaba.c=
om> wrote:
> > >
> > > On Tue, May 23, 2023 at 09:30:28AM -0400, Michael S. Tsirkin wrote:
> > > > On Tue, May 23, 2023 at 05:18:20PM +0800, Heng Qi wrote:
> > > > > On Tue, May 23, 2023 at 03:15:37AM -0400, Michael S. Tsirkin wrot=
e:
> > > > > > On Tue, May 23, 2023 at 10:41:18AM +0800, Heng Qi wrote:
> > > > > > > On Mon, May 22, 2023 at 03:10:05PM -0400, Michael S. Tsirkin =
wrote:
> > > > > > > > On Mon, May 22, 2023 at 08:12:00PM +0800, Heng Qi wrote:
> > > > > > > > > 1) Add a feature bit to the virtio specification to tell =
the sender that a fully
> > > > > > > > > csumed packet must be sent.
> > > > > > > >
> > > > > > > > Who is the sender in this picture? The driver?
> > > > > > >
> > > > > > > The device or the driver.
> > > > > > >
> > > > > > > When the device is hw, the sender is more likely to be a devi=
ce.
> > > > > > > When the device is sw, the sender can be a device or a driver=
.
> > > > > > >
> > > > > > > But in general, this feature is inclined to constrain the beh=
avior of the device and
> > > > > > > the driver from the receiving side.
> > > > > >
> > > > > > Based on above I am guessing you are talking about driver getti=
ng
> > > > > > packets from device, I wish you used terms from virtio spec.
> > > > >
> > > > > Yes, I'm going to use the terminology of the virtio spec.
> > > > >
> > > > > >
> > > > > > > For example:
> > > > > > > VIRTIO_NET_F_UNNECESSARY_CSUM : The driver tells the device t=
hat you must send me a fully csumed packet.
> > > > > > >
> > > > > > > Then the specific implementation can be
> > > > > > >
> > > > > > > (1) the sender sends a fully csumed packet;
> > > > > > > (2) the receiver receives a CHECKSUM_PARTIAL packet, and the =
device helps calculate the fully csum
> > > > > > >     (because the two parties in the communication are located=
 on the same host, the packet is trusted.).
> > > > > > >
> > > > > > > In summary, if VIRTIO_NET_F_UNNECESSARY_CSUM is negotiated, t=
he driver will no longer receive any packets marked CHECKSUM_PARTIAL.
> > > > > > >
> > > > > > > Thanks.
> > > > > >
> > > > > > This is what clearing VIRTIO_NET_F_GUEST_CSUM does.
> > > > >
> > > > > Yes, but with VIRTIO_NET_F_GUEST_CSUM cleared, although the devic=
e can
> > > > > receive a fully checksummed packet, we can no longer enjoy
> > > > > the device's ability to validate the packet checksum. That is, th=
e value
> > > > > of \field{flags} in the virtio_net_hdr structure is set to 0, whi=
ch means
> > > > > that the packet received by the driver will not be marked as
> > > > > VIRTIO_NET_HDR_F_DATA_VALID.
> > > > >
> > > > > So, we need a feature bit (let's say VIRTIO_NET_F_UNNECESSARY_CSU=
M).
> > > > > If VIRTIO_NET_F_UNNECESSARY_CSUM is negotiated, the device must g=
ive the
> > > > > driver a fully checksummed packet, and the packet is validated by=
 the
> > > > > device with \field{flags} set to VIRTIO_NET_HDR_F_DATA_VALID.
> > > > >
> > > > > >
> > > > > > I feel you are trying to say that clearing VIRTIO_NET_F_GUEST_C=
SUM
> > > > > > disables all offloads but you want to keep some of them?
> > > > > >
> > > > >
> > > > > No, what I mean is that a feature VIRTIO_NET_F_UNNECESSARY_CSUM i=
s needed
> > > > > in addition to VIRTIO_NET_F_GUEST_CSUM, if both features are nego=
tiated,
> > > > > then the driver may always receive packets marked as
> > > > > VIRTIO_NET_HDR_F_DATA_VALID, which means that we can now load XDP=
 at the
> > > > > same time.
> > > >
> > > > Makes no sense to me. VIRTIO_NET_F_GUEST_CSUM set already allows
> > > > VIRTIO_NET_HDR_F_DATA_VALID:
> > >
> > > We need to focus on what happens when the XDP program is loaded:
> > >
> > > The current virtio-net needs to turn off the VIRTIO_NET_F_GUEST_CSUM
> > > feature when loading XDP. The main reason for doing this is because
> > > VIRTIO_NET_F_GUEST_CSUM allows to receive packets marked as
> > > VIRTIO_NET_HDR_F_NEEDS_CSUM. Such packets are not compatible with
> > > XDP programs, because we cannot guarantee that the csum_{start, offse=
t}
> > > fields are correct after XDP modifies the packets.
> >
> > We can try to fix or workaround this. A rough idea is for example by
> > using a flow dissector?
>
> How can we fix this with a flow dissector? Could you please explain in
> detail?

I mean you can use a flow dissector to probe the csum_start and csum_offset=
.

>
> > Anyhow the GSO of virtio-net was marked as
> > dodgy which means the csum_start/offset needs to be validated again in
> > the xmit path. Or we can monitor if the packet is modified or not, if
> > not, we don't need to zero vnet header?
>
> Yes, this is a way, and we've thought about this solution.
> A relatively simple solution is to add a new flag to the XDP program
> (through XDP core layer), which indicates that the XDP program is a
> read-only XDP program (ie, does not modify the packet).

XDP used to have something like this. Maybe we can re add them.

> Then to load
> such an XDP program we no longer need to filter out the
> VIRTIO_NET_F_GUEST_CSUM feature.
>
> But why we didn't propose this solution in the 'Proposal', because it
> seems that only virtio-net has encountered related problems. Virtual
> network cards like veth, even if they receive partial csumed packets
> (corresponding to virtio-net's packets marked as
> VIRTIO_NET_HDR_F_NEEDS_CSUM), they still open NETIF_F_RXCSUM
> (corresponding to virtio-net's VIRTIO_NET_F_GUEST_CSUM). So there is
> another trade-off: the current virtnet_xdp_set() no longer
> filters out VIRTIO_NET_F_GUEST_CSUM.
>
> The reasons I think are the following:
> 1. Referring to veth=E2=80=99s way, the XDP program is more of a
> monitoring/firewall, and may not modify data packets.

Probably not, XDP could be used for building tunnels.

>
> 2. We can still use XDP for packets marked as
> VIRTIO_NET_HDR_F_DATA_VALID.

Not sure I get this but who is going to adjust csum_start/offset?

>
> 3. Packets converted from xdp_{buff, frame} may not be ip_forwarded
> (because ip_forward sysctl is disabled by default)

That's suboptimal.

Thanks

>
> Thanks.
>
> >
> > Thanks
> >
> > >
> > > So in order for the driver to continue to enjoy the device's ability =
to
> > > validate packets while XDP is loaded, we need a new feature to tell t=
he
> > > device not to deliver packets marked as VIRTIO_NET_HDR_F_NEEDS_CSUM (=
in
> > > other words, the device can only deliver packets marked as
> > > VIRTIO_NET_HDR_F_DATA_VALID).
> > >
> > > Thanks.
> > >
> > > > \item If the VIRTIO_NET_F_GUEST_CSUM feature was negotiated, the
> > > >   VIRTIO_NET_HDR_F_NEEDS_CSUM bit in \field{flags} can be
> > > >   set: if so, the packet checksum at offset \field{csum_offset}
> > > >   from \field{csum_start} and any preceding checksums
> > > >   have been validated.  The checksum on the packet is incomplete an=
d
> > > >   if bit VIRTIO_NET_HDR_F_RSC_INFO is not set in \field{flags},
> > > >   then \field{csum_start} and \field{csum_offset} indicate how to c=
alculate it
> > > >   (see Packet Transmission point 1).
> > > >
> > > > Did you maybe mean if either feature is negotiated?
> > > >
> > > >
> > > >
> > > > > > Again please use virtio terminology not Linux. to help you out,
> > > > > > in current linux, VIRTIO_NET_HDR_F_NEEDS_CSUM and VIRTIO_NET_HD=
R_F_DATA_VALID
> > > > > > will set CHECKSUM_PARTIAL and CHECKSUM_UNNECESSARY respectively=
.
> > > > > >
> > > > >
> > > > > Sure. Will do as you suggested.
> > > > >
> > > > > Thanks.
> > > > >
> > > > > >
> > > > > > --
> > > > > > MST
> > > > > >
> > > > > >
> > > > > > ---------------------------------------------------------------=
------
> > > > > > To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open=
.org
> > > > > > For additional commands, e-mail: virtio-dev-help@lists.oasis-op=
en.org
> > > >
> > > >
> > > > This publicly archived list offers a means to provide input to the
> > > > OASIS Virtual I/O Device (VIRTIO) TC.
> > > >
> > > > In order to verify user consent to the Feedback License terms and
> > > > to minimize spam in the list archive, subscription is required
> > > > before posting.
> > > >
> > > > Subscribe: virtio-comment-subscribe@lists.oasis-open.org
> > > > Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
> > > > List help: virtio-comment-help@lists.oasis-open.org
> > > > List archive: https://lists.oasis-open.org/archives/virtio-comment/
> > > > Feedback License: https://www.oasis-open.org/who/ipr/feedback_licen=
se.pdf
> > > > List Guidelines: https://www.oasis-open.org/policies-guidelines/mai=
ling-lists
> > > > Committee: https://www.oasis-open.org/committees/virtio/
> > > > Join OASIS: https://www.oasis-open.org/join/
> > >
>


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

