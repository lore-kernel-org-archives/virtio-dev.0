Return-Path: <virtio-dev-return-12799-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89292C7EE23
	for <virtio-dev@archiver.kernel.org>; Wed, 24 May 2023 04:09:39 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id CA4214457
	for <virtio-dev@archiver.kernel.org>; Wed, 24 May 2023 04:09:38 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 9DC02986415
	for <virtio-dev@archiver.kernel.org>; Wed, 24 May 2023 04:09:38 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 81C5798628B; Wed, 24 May 2023 04:09:38 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 706019863FC
	for <virtio-dev@lists.oasis-open.org>; Wed, 24 May 2023 04:09:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: 3AaVQJEUMf2fOkNW3MylWw-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684901373; x=1687493373;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9h4+mPWARSMWTSgNBGXLaJKepM11S77N/TL6iHEDhck=;
        b=Un6RZuL7PnQWPYEA8DC/UUmvl6Hgqu9bb4WV9wj8PlAfMNwVlqtxLp8WjGl4aIaIUt
         DcuyfdcAFZiQHJUB4KkSzOgIA/O3XbqKOZgQxKZ40+eF3QIQnLVjRtIVNMj+IgrItTXQ
         CwvgPpU17/JN/rZtgp27LdXAe2UCMrUEZ1bWjv76pCriknZHsWDtRjkSrvaMyDYJIByz
         yGPKjZgvOHzY6HVDDx7E9ys0kNjaGD2yryInuBHZlgoDh3BwP2xx+UBLpC5tn4Y4qZEl
         7Y0eekHP1jaDViYwHusgT5ivN8m7o8MGidWaH/lI2uJhfFmP8h4/nxkQml1JTbcq9i6E
         bo1w==
X-Gm-Message-State: AC+VfDy3QTm4zMNU2pDLp5zipkH1fnytSVbnMS8dBFoOYQ57Mxgtvv17
	LPZ8qsjlT/XT7Yp+WKy4EoLPVqV5Zz81z8S8JQYUOgAvgX0BSrcWH+yTcBJFOO51y7fbAWlfaBl
	CglE5IrrHtVzQAsgcwH/7uTohjm2gyDgjx5VbmJkS1k/r
X-Received: by 2002:a05:6512:2308:b0:4f3:bb19:3bd6 with SMTP id o8-20020a056512230800b004f3bb193bd6mr3544096lfu.34.1684901373767;
        Tue, 23 May 2023 21:09:33 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4KjSEYuR/pYN2KcinDPAs9pSpxWrqdT9qeEhut6ueuw+oRj5wjL9kvs7R1CsmNTxLrbcl2JasLKJ7n0/sOsYI=
X-Received: by 2002:a05:6512:2308:b0:4f3:bb19:3bd6 with SMTP id
 o8-20020a056512230800b004f3bb193bd6mr3544089lfu.34.1684901373397; Tue, 23 May
 2023 21:09:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230522121200.40939-1-hengqi@linux.alibaba.com>
 <20230522150743-mutt-send-email-mst@kernel.org> <20230523024118.GA23504@h68b04307.sqa.eu95>
 <20230523024057-mutt-send-email-mst@kernel.org> <20230523091820.GC23504@h68b04307.sqa.eu95>
 <20230523092237-mutt-send-email-mst@kernel.org> <20230523135144.GD23504@h68b04307.sqa.eu95>
In-Reply-To: <20230523135144.GD23504@h68b04307.sqa.eu95>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 24 May 2023 12:09:22 +0800
Message-ID: <CACGkMEscLOVssyAeTYZE0o_KT86UazdBdj9NKPrmK5=g6YcBuA@mail.gmail.com>
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, virtio-dev@lists.oasis-open.org, 
	virtio-comment@lists.oasis-open.org, Parav Pandit <parav@nvidia.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [virtio-dev] Re: [virtio-comment] Re: [virtio-dev] Re: [Proposal] Relationship
 between XDP and rx-csum in virtio-net

On Tue, May 23, 2023 at 9:51=E2=80=AFPM Heng Qi <hengqi@linux.alibaba.com> =
wrote:
>
> On Tue, May 23, 2023 at 09:30:28AM -0400, Michael S. Tsirkin wrote:
> > On Tue, May 23, 2023 at 05:18:20PM +0800, Heng Qi wrote:
> > > On Tue, May 23, 2023 at 03:15:37AM -0400, Michael S. Tsirkin wrote:
> > > > On Tue, May 23, 2023 at 10:41:18AM +0800, Heng Qi wrote:
> > > > > On Mon, May 22, 2023 at 03:10:05PM -0400, Michael S. Tsirkin wrot=
e:
> > > > > > On Mon, May 22, 2023 at 08:12:00PM +0800, Heng Qi wrote:
> > > > > > > 1) Add a feature bit to the virtio specification to tell the =
sender that a fully
> > > > > > > csumed packet must be sent.
> > > > > >
> > > > > > Who is the sender in this picture? The driver?
> > > > >
> > > > > The device or the driver.
> > > > >
> > > > > When the device is hw, the sender is more likely to be a device.
> > > > > When the device is sw, the sender can be a device or a driver.
> > > > >
> > > > > But in general, this feature is inclined to constrain the behavio=
r of the device and
> > > > > the driver from the receiving side.
> > > >
> > > > Based on above I am guessing you are talking about driver getting
> > > > packets from device, I wish you used terms from virtio spec.
> > >
> > > Yes, I'm going to use the terminology of the virtio spec.
> > >
> > > >
> > > > > For example:
> > > > > VIRTIO_NET_F_UNNECESSARY_CSUM : The driver tells the device that =
you must send me a fully csumed packet.
> > > > >
> > > > > Then the specific implementation can be
> > > > >
> > > > > (1) the sender sends a fully csumed packet;
> > > > > (2) the receiver receives a CHECKSUM_PARTIAL packet, and the devi=
ce helps calculate the fully csum
> > > > >     (because the two parties in the communication are located on =
the same host, the packet is trusted.).
> > > > >
> > > > > In summary, if VIRTIO_NET_F_UNNECESSARY_CSUM is negotiated, the d=
river will no longer receive any packets marked CHECKSUM_PARTIAL.
> > > > >
> > > > > Thanks.
> > > >
> > > > This is what clearing VIRTIO_NET_F_GUEST_CSUM does.
> > >
> > > Yes, but with VIRTIO_NET_F_GUEST_CSUM cleared, although the device ca=
n
> > > receive a fully checksummed packet, we can no longer enjoy
> > > the device's ability to validate the packet checksum. That is, the va=
lue
> > > of \field{flags} in the virtio_net_hdr structure is set to 0, which m=
eans
> > > that the packet received by the driver will not be marked as
> > > VIRTIO_NET_HDR_F_DATA_VALID.
> > >
> > > So, we need a feature bit (let's say VIRTIO_NET_F_UNNECESSARY_CSUM).
> > > If VIRTIO_NET_F_UNNECESSARY_CSUM is negotiated, the device must give =
the
> > > driver a fully checksummed packet, and the packet is validated by the
> > > device with \field{flags} set to VIRTIO_NET_HDR_F_DATA_VALID.
> > >
> > > >
> > > > I feel you are trying to say that clearing VIRTIO_NET_F_GUEST_CSUM
> > > > disables all offloads but you want to keep some of them?
> > > >
> > >
> > > No, what I mean is that a feature VIRTIO_NET_F_UNNECESSARY_CSUM is ne=
eded
> > > in addition to VIRTIO_NET_F_GUEST_CSUM, if both features are negotiat=
ed,
> > > then the driver may always receive packets marked as
> > > VIRTIO_NET_HDR_F_DATA_VALID, which means that we can now load XDP at =
the
> > > same time.
> >
> > Makes no sense to me. VIRTIO_NET_F_GUEST_CSUM set already allows
> > VIRTIO_NET_HDR_F_DATA_VALID:
>
> We need to focus on what happens when the XDP program is loaded:
>
> The current virtio-net needs to turn off the VIRTIO_NET_F_GUEST_CSUM
> feature when loading XDP. The main reason for doing this is because
> VIRTIO_NET_F_GUEST_CSUM allows to receive packets marked as
> VIRTIO_NET_HDR_F_NEEDS_CSUM. Such packets are not compatible with
> XDP programs, because we cannot guarantee that the csum_{start, offset}
> fields are correct after XDP modifies the packets.

We can try to fix or workaround this. A rough idea is for example by
using a flow dissector? Anyhow the GSO of virtio-net was marked as
dodgy which means the csum_start/offset needs to be validated again in
the xmit path. Or we can monitor if the packet is modified or not, if
not, we don't need to zero vnet header?

Thanks

>
> So in order for the driver to continue to enjoy the device's ability to
> validate packets while XDP is loaded, we need a new feature to tell the
> device not to deliver packets marked as VIRTIO_NET_HDR_F_NEEDS_CSUM (in
> other words, the device can only deliver packets marked as
> VIRTIO_NET_HDR_F_DATA_VALID).
>
> Thanks.
>
> > \item If the VIRTIO_NET_F_GUEST_CSUM feature was negotiated, the
> >   VIRTIO_NET_HDR_F_NEEDS_CSUM bit in \field{flags} can be
> >   set: if so, the packet checksum at offset \field{csum_offset}
> >   from \field{csum_start} and any preceding checksums
> >   have been validated.  The checksum on the packet is incomplete and
> >   if bit VIRTIO_NET_HDR_F_RSC_INFO is not set in \field{flags},
> >   then \field{csum_start} and \field{csum_offset} indicate how to calcu=
late it
> >   (see Packet Transmission point 1).
> >
> > Did you maybe mean if either feature is negotiated?
> >
> >
> >
> > > > Again please use virtio terminology not Linux. to help you out,
> > > > in current linux, VIRTIO_NET_HDR_F_NEEDS_CSUM and VIRTIO_NET_HDR_F_=
DATA_VALID
> > > > will set CHECKSUM_PARTIAL and CHECKSUM_UNNECESSARY respectively.
> > > >
> > >
> > > Sure. Will do as you suggested.
> > >
> > > Thanks.
> > >
> > > >
> > > > --
> > > > MST
> > > >
> > > >
> > > > -------------------------------------------------------------------=
--
> > > > To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> > > > For additional commands, e-mail: virtio-dev-help@lists.oasis-open.o=
rg
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

