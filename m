Return-Path: <virtio-dev-return-12788-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50161C7EE26
	for <virtio-dev@archiver.kernel.org>; Tue, 23 May 2023 13:30:42 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 7C6592ACB2
	for <virtio-dev@archiver.kernel.org>; Tue, 23 May 2023 13:30:40 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 69A2C986407
	for <virtio-dev@archiver.kernel.org>; Tue, 23 May 2023 13:30:40 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 5798D983F7B; Tue, 23 May 2023 13:30:40 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 434C69863D0
	for <virtio-dev@lists.oasis-open.org>; Tue, 23 May 2023 13:30:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: RwK5RltZOcGkDXX71rfmUQ-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684848635; x=1687440635;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7KQ/T023xndmUClFUfo0ErdpOY/KOjddttZGedy82hQ=;
        b=SovFuR2MtAveH8eERkPiI2MbVa5ci3VbXYmwQ/VRarAFR0p8Reu2DyzsTzoA4JMaEE
         JthKhXNH5xNno67QWkGrsmYkX08yNGrtLNLWN9h0UqLBup4PDbolNC06ktQ15zzk7M5/
         x2W0nqAQanz8ffLZzpOOJ1OtqmmislIXw3W4ioZGjR9PVkSLfezIV75oVKYojxT1qqcy
         l+20LpznTKNhHtB5Bgn5PLU2TZ6DsDTImvjzWI9pV6Ef2M2ddnB0evk38ep2X43iyhKB
         oGFjp1ZlDUDEc0E+FMLh0Rlph3GZJS9fH9G+2tN/SGRuTwJAJ/04EqQw7ejRpPTJ01ml
         2QEQ==
X-Gm-Message-State: AC+VfDzGFtEko7dHfTgdkdRAYicrI+QmG+4i2xhV+S8GfO/+hftLvehU
	Zs4TIHiE6q/Yo7uU5a0Zg7XJ1P8dfTHsgkJAGTXnrkxZyf72wMY8mDTJkO3M3uLmJFbZuX1l2Kt
	HOi5UEcV406EuRwohreIZuoixmSSN
X-Received: by 2002:a19:f81a:0:b0:4e8:3fca:4927 with SMTP id a26-20020a19f81a000000b004e83fca4927mr4072480lff.58.1684848635309;
        Tue, 23 May 2023 06:30:35 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6pXdY2G0a1EFQQ/8oTtzKWwGA4WYPCA7a8+4N3gUKKXaRfqLBPU7oUlmRFretffHy0cL6IWA==
X-Received: by 2002:a19:f81a:0:b0:4e8:3fca:4927 with SMTP id a26-20020a19f81a000000b004e83fca4927mr4072470lff.58.1684848634926;
        Tue, 23 May 2023 06:30:34 -0700 (PDT)
Date: Tue, 23 May 2023 09:30:28 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: virtio-dev@lists.oasis-open.org, virtio-comment@lists.oasis-open.org,
	Jason Wang <jasowang@redhat.com>, Parav Pandit <parav@nvidia.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Message-ID: <20230523092237-mutt-send-email-mst@kernel.org>
References: <20230522121200.40939-1-hengqi@linux.alibaba.com>
 <20230522150743-mutt-send-email-mst@kernel.org>
 <20230523024118.GA23504@h68b04307.sqa.eu95>
 <20230523024057-mutt-send-email-mst@kernel.org>
 <20230523091820.GC23504@h68b04307.sqa.eu95>
MIME-Version: 1.0
In-Reply-To: <20230523091820.GC23504@h68b04307.sqa.eu95>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: Re: [virtio-dev] Re: [Proposal] Relationship between XDP and rx-csum
 in virtio-net

On Tue, May 23, 2023 at 05:18:20PM +0800, Heng Qi wrote:
> On Tue, May 23, 2023 at 03:15:37AM -0400, Michael S. Tsirkin wrote:
> > On Tue, May 23, 2023 at 10:41:18AM +0800, Heng Qi wrote:
> > > On Mon, May 22, 2023 at 03:10:05PM -0400, Michael S. Tsirkin wrote:
> > > > On Mon, May 22, 2023 at 08:12:00PM +0800, Heng Qi wrote:
> > > > > 1) Add a feature bit to the virtio specification to tell the sender that a fully
> > > > > csumed packet must be sent.
> > > > 
> > > > Who is the sender in this picture? The driver?
> > > 
> > > The device or the driver.
> > > 
> > > When the device is hw, the sender is more likely to be a device.
> > > When the device is sw, the sender can be a device or a driver.
> > >
> > > But in general, this feature is inclined to constrain the behavior of the device and
> > > the driver from the receiving side.
> > 
> > Based on above I am guessing you are talking about driver getting
> > packets from device, I wish you used terms from virtio spec.
> 
> Yes, I'm going to use the terminology of the virtio spec.
> 
> > 
> > > For example: 
> > > VIRTIO_NET_F_UNNECESSARY_CSUM : The driver tells the device that you must send me a fully csumed packet.
> > > 
> > > Then the specific implementation can be
> > > 
> > > (1) the sender sends a fully csumed packet;
> > > (2) the receiver receives a CHECKSUM_PARTIAL packet, and the device helps calculate the fully csum
> > >     (because the two parties in the communication are located on the same host, the packet is trusted.).
> > > 
> > > In summary, if VIRTIO_NET_F_UNNECESSARY_CSUM is negotiated, the driver will no longer receive any packets marked CHECKSUM_PARTIAL.
> > > 
> > > Thanks.
> > 
> > This is what clearing VIRTIO_NET_F_GUEST_CSUM does.
> 
> Yes, but with VIRTIO_NET_F_GUEST_CSUM cleared, although the device can
> receive a fully checksummed packet, we can no longer enjoy
> the device's ability to validate the packet checksum. That is, the value
> of \field{flags} in the virtio_net_hdr structure is set to 0, which means
> that the packet received by the driver will not be marked as
> VIRTIO_NET_HDR_F_DATA_VALID.
> 
> So, we need a feature bit (let's say VIRTIO_NET_F_UNNECESSARY_CSUM).
> If VIRTIO_NET_F_UNNECESSARY_CSUM is negotiated, the device must give the
> driver a fully checksummed packet, and the packet is validated by the
> device with \field{flags} set to VIRTIO_NET_HDR_F_DATA_VALID.
> 
> > 
> > I feel you are trying to say that clearing VIRTIO_NET_F_GUEST_CSUM
> > disables all offloads but you want to keep some of them?
> > 
> 
> No, what I mean is that a feature VIRTIO_NET_F_UNNECESSARY_CSUM is needed
> in addition to VIRTIO_NET_F_GUEST_CSUM, if both features are negotiated,
> then the driver may always receive packets marked as
> VIRTIO_NET_HDR_F_DATA_VALID, which means that we can now load XDP at the
> same time.

Makes no sense to me. VIRTIO_NET_F_GUEST_CSUM set already allows
VIRTIO_NET_HDR_F_DATA_VALID:
\item If the VIRTIO_NET_F_GUEST_CSUM feature was negotiated, the
  VIRTIO_NET_HDR_F_NEEDS_CSUM bit in \field{flags} can be
  set: if so, the packet checksum at offset \field{csum_offset}
  from \field{csum_start} and any preceding checksums
  have been validated.  The checksum on the packet is incomplete and
  if bit VIRTIO_NET_HDR_F_RSC_INFO is not set in \field{flags}, 
  then \field{csum_start} and \field{csum_offset} indicate how to calculate it
  (see Packet Transmission point 1).

Did you maybe mean if either feature is negotiated?



> > Again please use virtio terminology not Linux. to help you out,
> > in current linux, VIRTIO_NET_HDR_F_NEEDS_CSUM and VIRTIO_NET_HDR_F_DATA_VALID
> > will set CHECKSUM_PARTIAL and CHECKSUM_UNNECESSARY respectively.
> > 
> 
> Sure. Will do as you suggested.
> 
> Thanks.
> 
> > 
> > -- 
> > MST
> > 
> > 
> > ---------------------------------------------------------------------
> > To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> > For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

