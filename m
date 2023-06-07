Return-Path: <virtio-dev-return-12879-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12FE3C77B7A
	for <virtio-dev@archiver.kernel.org>; Wed,  7 Jun 2023 08:57:32 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 738BE732E5
	for <virtio-dev@archiver.kernel.org>; Wed,  7 Jun 2023 08:57:31 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 6F30E986666
	for <virtio-dev@archiver.kernel.org>; Wed,  7 Jun 2023 08:57:31 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 62D72986653; Wed,  7 Jun 2023 08:57:31 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4F6F798664F
	for <virtio-dev@lists.oasis-open.org>; Wed,  7 Jun 2023 08:57:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: QE0AlckMNvaxo5yn59zrnw-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686128244; x=1688720244;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ucg3jCxL78xCcPTdrV+9X0SV41LLLRqrkj85Fd8Z0vk=;
        b=kUw3gUJpFp8Oi5Me6Q5+TvQ0g7lRx85uxNu/VVsILTkmrLvbz1JUKYRAy06p3z+Xlm
         ETl3V+2dnYIdq9EJ715BGe+iJcRoxCjEVRp1Wq8GX1RjMPnE4hZjz2XIMa/aXXHasHA0
         kf0cMkapKp1XhoyQ9QQ+g4v7LQUF8oCtYkXr0XoUN2XNVAzNqzMEPaQnOzpt1z1ZOAMw
         U7bHnmiLkDbRtqVMwPZ7+VQ+XUsYityIK9hXbk4+6NT9/KPtOnjzCeMrJRiAFP76NvLQ
         GxIjsayfoddXsaoi4qNy6ngWCTs6TWeZzoDws2nwt19BVwtjfoqd5IfjFTF5pPrfpuDw
         DeAg==
X-Gm-Message-State: AC+VfDyhvcHnwngYGr34Tldw4+3VncCwyIVTmli7T0xkCwxsvRsY2Bme
	EPLlWxgejUkb8HP3erhuJxgPCUVfjMNNdfz/rKyWmRIzjdFDMICs8QBjGBxvEU1dhlLbuOytvsx
	KP4Fk4hKOEf2zND1/9jCEXqeCZRFm
X-Received: by 2002:a5d:480b:0:b0:30e:5b7c:de1c with SMTP id l11-20020a5d480b000000b0030e5b7cde1cmr847381wrq.11.1686128244209;
        Wed, 07 Jun 2023 01:57:24 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5cVBV6nE7RtmcEBXn+HzuRodoDcm43tX6NFthW7AyByONHB9mNt2RgHuwDFwOrvr3zyeFr0A==
X-Received: by 2002:a5d:480b:0:b0:30e:5b7c:de1c with SMTP id l11-20020a5d480b000000b0030e5b7cde1cmr847364wrq.11.1686128243933;
        Wed, 07 Jun 2023 01:57:23 -0700 (PDT)
Date: Wed, 7 Jun 2023 04:57:19 -0400
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
Message-ID: <20230607045414-mutt-send-email-mst@kernel.org>
References: <20230604174224-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481DABA25CA36A5460B13E5DC4CA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230605014539-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481C14D65D5E10CD23A9F67DC4DA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230605092859-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481CEB3A34AAB49A282F2A8DC4DA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230605174755-mutt-send-email-mst@kernel.org>
 <PH0PR12MB548180E16376862A3C0DFF1DDC4DA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230606073544-mutt-send-email-mst@kernel.org>
 <CACGkMEv1so_KGwJZG3GnAf=JNky7+BMNK7N4NTtucDS+WyW5VA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEv1so_KGwJZG3GnAf=JNky7+BMNK7N4NTtucDS+WyW5VA@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Subject: Re: [virtio-dev] Re: [PATCH v3 0/3] transport-pci: Introduce legacy
 registers access using AQ

On Wed, Jun 07, 2023 at 10:27:12AM +0800, Jason Wang wrote:
> On Tue, Jun 6, 2023 at 7:56 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Mon, Jun 05, 2023 at 10:12:59PM +0000, Parav Pandit wrote:
> > > Rolling v4 now.
> >
> > Great thanks! I think the result will be in a good shape from
> > the ABI point of view. Good job!
> >
> > I think so far Jason was the only one with significant comments
> > on the series so let's see what he says.
> 
> I can't say I like this. I prefer to do meditation on top of a modern
> device with some lightweight features like _F_LEAGCY_HEADER. I don't
> see any advantages of a new legacy ABI over _F_LEGACY_HEADER. I don't
> want to repeat but I don't get any response here
> 
> https://lore.kernel.org/virtio-dev/CACGkMEuixsBibSq_pEQvcKOH0WBQWnta4Q2c28SV8qTS8gaVcA@mail.gmail.com/#t


After trying to write this I came away with a conviction that
if hardware vendors are prepared to implement legacy
in hardware we should let them do exactly that.


> >
> > From my personal POV what will be left to do to get this
> > feature ready for merging would be
> >
> > - tightening the language:
> > - thinking of and addressing all kind of corner cases.
> 
> We need first to check whether it's possible (not too late) to find
> all the corner cases.
> 
> Thanks

For sure, but of course we need to stop arguing about whether
to have the feature in the 1st place.

> >
> >
> > Since by now from our email discussions I have I think
> > a decent understanding of how the feature is supposed to work
> > I understand how these things work but I think there are still
> > things that would be a bit unclear for an unprepared reader.
> >
> > Just to give a random example, there's no explicit
> > time where the member kind of switches to the legacy/back to modern
> > mode. I am guessing setting DRIVER bit through legacy interface
> > does this. We'll want to list that.
> >
> > I'll try to help find these issues and maybe even suggest wording.
> >
> > I've delayed commenting on these until the high level design is agreed
> > on, didn't want to make you waste time on polishing as the patches
> > undergo significant changes, and I suggest you do the same in v4: let's
> > make sure there's a wide agreement on the ABI then focus on the spec
> > language.
> >
> >
> >
> > --
> > MST
> >


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

