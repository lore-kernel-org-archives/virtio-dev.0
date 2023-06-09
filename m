Return-Path: <virtio-dev-return-12919-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 080A8C7EE2F
	for <virtio-dev@archiver.kernel.org>; Fri,  9 Jun 2023 07:15:57 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 2E79C2B054
	for <virtio-dev@archiver.kernel.org>; Fri,  9 Jun 2023 07:15:57 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 14B269866AB
	for <virtio-dev@archiver.kernel.org>; Fri,  9 Jun 2023 07:15:57 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id EAAA398668F; Fri,  9 Jun 2023 07:15:56 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D763B986692
	for <virtio-dev@lists.oasis-open.org>; Fri,  9 Jun 2023 07:15:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: ZBL_L2lrMlWQigSP0OS3gA-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686294953; x=1688886953;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gPmOGRtFStVlKsb8ZE/dzk4Vna2GFD2/PSOsT1Q3Fzk=;
        b=H2MesN2BkAi9PGnXdhQCdyqInMUOOXUta95NOL6Bb+81mqKqK077enS78HwfzV2nHl
         zjEI8gR36JIRMOy5GzST/lzU1HpiNOLnvMhXC5xczrmTC60aLdLpSSsW8sRDXGxREVso
         31Ixs8KQI7F+8vrWDkSzXMlsBIr61VZY/he7qx1GiTy3t858ib9H6/7OxD9sr+qhpyIo
         dQpggX7VqO09/HgX4aS5MBr3gOYcpW8J68yBWX9JKoQf9pNPtw3HURrCeqm6EWj0GDDH
         qqHwIWf+Syje6SsRPNSArVvioikrSjsOErVj+/PraQJjFK1+Fiw+TscoWDkE/HLYhNsA
         n3WA==
X-Gm-Message-State: AC+VfDy3NqSCgcBJWcHpcFrDNPlvWIXPaiGRuZjREiCt6/21EW35fTbE
	LPlSujwYPEbxhdkPGuTFvqr5n8Yd6HB33Q4nvO2juHzBsBC2RqgdCaeX5dy+Ae+XjaLKosW+0P5
	xE+jY+0/Mkh9YLkIEml6JfgYOo6Kx
X-Received: by 2002:a05:6000:4d1:b0:30a:e5e3:cdf1 with SMTP id h17-20020a05600004d100b0030ae5e3cdf1mr429712wri.7.1686294953673;
        Fri, 09 Jun 2023 00:15:53 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ45ykwCD+ZzpWzElH/ER4D/+PKKjAz9leOPDaSsdZGrihFrBeONiajurvKediu6fFTPi4Vh0A==
X-Received: by 2002:a05:6000:4d1:b0:30a:e5e3:cdf1 with SMTP id h17-20020a05600004d100b0030ae5e3cdf1mr429686wri.7.1686294953283;
        Fri, 09 Jun 2023 00:15:53 -0700 (PDT)
Date: Fri, 9 Jun 2023 03:15:48 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Parav Pandit <parav@nvidia.com>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"cohuck@redhat.com" <cohuck@redhat.com>,
	"david.edmondson@oracle.com" <david.edmondson@oracle.com>,
	"sburla@marvell.com" <sburla@marvell.com>,
	Yishai Hadas <yishaih@nvidia.com>, Maor Gottlieb <maorg@nvidia.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	Shahaf Shuler <shahafs@nvidia.com>
Message-ID: <20230609030109-mutt-send-email-mst@kernel.org>
References: <20230605092859-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481CEB3A34AAB49A282F2A8DC4DA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230605174755-mutt-send-email-mst@kernel.org>
 <PH0PR12MB548180E16376862A3C0DFF1DDC4DA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230606073544-mutt-send-email-mst@kernel.org>
 <CACGkMEv1so_KGwJZG3GnAf=JNky7+BMNK7N4NTtucDS+WyW5VA@mail.gmail.com>
 <PH0PR12MB5481D80A48F3BD82D86B3DB0DC53A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEsVrqCGJJ2Q5OGbgPdtEJHTpvVt6nEKP_MzkSH_-cOa6w@mail.gmail.com>
 <PH0PR12MB54810313CA6DD1995F52745DDC50A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEsy=pG=LT0hOT-PO3HTkk3NOAu6qA_GaZpKwqq8B996cA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEsy=pG=LT0hOT-PO3HTkk3NOAu6qA_GaZpKwqq8B996cA@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Subject: Re: [virtio-dev] Re: [PATCH v3 0/3] transport-pci: Introduce legacy
 registers access using AQ

On Fri, Jun 09, 2023 at 10:06:43AM +0800, Jason Wang wrote:
> On Thu, Jun 8, 2023 at 10:38 PM Parav Pandit <parav@nvidia.com> wrote:
> >
> >
> > > From: Jason Wang <jasowang@redhat.com>
> > > Sent: Wednesday, June 7, 2023 2:54 AM
> >
> > > Hypervisor can trap the legacy device configuration space write and convert it
> > > to cvq commands.
> > Michael already answered that cvq is not trapped; this is the main design goal we talked several times that it is passthrough device.
> 
> Is this really a blocker? Wouldn't a new feature(_F_LEFACY_MAC) or cap
> resolve this?

Of course we can create a set of feature bits emulating legacy.

> >
> > So no point discussing this again.
> >
> > If you have any comments on v4, please let me know.
> >
> > Both the design points are addressed in v4.
> > 1. To split to two commands for device and config area
> > 2. Use pci cap to learn about notification region
> >
> > Since this ABI reflects what we agree on,
> 
> I think not since you fail to explain why this approach is better than
> simply adding new features like _F_LEGACY_HEADER and _F_LEGACY_MAC.
> 
> Thanks

I can explain, I think it's better for these reasons:

- limit the scope. We started out with _F_LEGACY_HEADER
  but now there's _F_LEGACY_MAC too. What about other
  device types? Could be nasty surprises there too.
  This way we just say "make legacy guests work" and
  this is the problem of the hardware vendor not ours.

- limit the impact. We don't get to maintain the set of hacks
  needed for legacy in the hypervisor - when some weird legacy
  support requirement surfaces, it will be up to the vendor
  to fix. HW vendors are also more agressive in deprecating
  old hardware - they will just stop shipping new
  hardware when there are no new customers and we can
  stop adding new hacks.

- test out admin command interface. This use-case is smaller
  than full transport vq but similar enough that
  we will learn valuable lessons from it.
  For example, it already helped us find and correct
  a design mistake where admin commands had 8 byte aligned length.
  As another example, I am working on ability to report events to admin command
  infrastructure which is currently missing.
  With that in place we will be able to add INT#x emulation for very old
  guests.



In short, this interface as you correctly point out is not the normal
way we build interfaces since it is not modular and less flexible than
individual feature bits.  However, for the legacy interface this might
be a good thing.


> > I would want to raise for vote in coming days to be part of 1.3 in few days as we have more than 3 weeks to sort out non-ABI language part.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

