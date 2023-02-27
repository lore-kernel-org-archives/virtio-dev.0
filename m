Return-Path: <virtio-dev-return-11305-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE74BC64ED6
	for <virtio-dev@archiver.kernel.org>; Mon, 27 Feb 2023 07:30:05 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 2550F42569
	for <virtio-dev@archiver.kernel.org>; Mon, 27 Feb 2023 07:30:04 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id AC9D5986478
	for <virtio-dev@archiver.kernel.org>; Mon, 27 Feb 2023 07:30:03 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 935719863ED; Mon, 27 Feb 2023 07:30:03 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-Id: <virtio-dev.lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 6F7289867A1
	for <virtio-dev@lists.oasis-open.org>; Mon, 27 Feb 2023 07:30:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: 7q3DE8opP8OxL_bgpmOlHQ-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rNUfwFaFOY8QX6jGal77DS3EdlL8Gkt7tXai/vH/f/o=;
        b=zvz66QAywiycAIxsmQX3BnUI88TR8G07+XGcbC+9rLytIXQAeenN/LzfquOTYLBhcu
         ObmHdbGSBl5SKAOo/5r1szGeF9vZ/zaHe9AfIT9f4uBPTvHePjLboQMBcaWaH8H85XyV
         jhF3MMHMsDWacrlUY5hLlBgQrMeTJS6PnbKqkBNXVYH4prflpFW/gTsCsuZTQTr21/Sg
         e/JHXRXbttkEV+XMDifhutj937ke18kWoeDMFRGRBc1dH8VwTiAz6WAAeOpYGlZZydFn
         uJx7zdWzUz457WgFbHJvGLwiwJSkl1SB89j5kA9/HzFfE+XUwSkbGR739BFQ2AHrPmGG
         VyGA==
X-Gm-Message-State: AO0yUKVg2+VMFz9aZlyOLxCJLBcS+FDcgvIJ2GA4bNYSQEwtwhBGf9Lr
	Yb3pzdOFKhZpaa9sbBtNkSiY4O+PsI8ssLVySLDQ56KSG911/p7AninoBObPDCwBrZNZoS/V11c
	BVEsLp6Rj1KJypSWPkrr9qkjnSzvu
X-Received: by 2002:a17:906:5acb:b0:886:7eae:26c4 with SMTP id x11-20020a1709065acb00b008867eae26c4mr31162485ejs.5.1677482999185;
        Sun, 26 Feb 2023 23:29:59 -0800 (PST)
X-Google-Smtp-Source: AK7set9dcknCyOVszSciiDXf2VKqORKvwGpe8u1jyIUWDGdO947rjyyPtC9D4QpAfj/y8qUuOVOPEA==
X-Received: by 2002:a17:906:5acb:b0:886:7eae:26c4 with SMTP id x11-20020a1709065acb00b008867eae26c4mr31162472ejs.5.1677482998906;
        Sun, 26 Feb 2023 23:29:58 -0800 (PST)
Date: Mon, 27 Feb 2023 02:29:54 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"cohuck@redhat.com" <cohuck@redhat.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	Shahaf Shuler <shahafs@nvidia.com>
Message-ID: <20230227022459-mutt-send-email-mst@kernel.org>
References: <20230225220636.429990-1-parav@nvidia.com>
 <20230225220636.429990-3-parav@nvidia.com>
 <20230225175847-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54811B0B6E6E95A659DA41B0DCAF9@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB54811B0B6E6E95A659DA41B0DCAF9@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [PATCH v1 2/2] transport-pci: Move transitional device id to
 legacy section
Message-ID: <20230227072954.yKLVlmPrIBQdg6xO_3duWCAziaPcyOU4UY1uoiytsaY@z>

On Mon, Feb 27, 2023 at 02:54:09AM +0000, Parav Pandit wrote:
> 
> 
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Saturday, February 25, 2023 6:00 PM
> > 
> > On Sun, Feb 26, 2023 at 12:06:36AM +0200, Parav Pandit wrote:
> > > Currently PCI device requirements section contains mix of normative
> > > statements for for regular (non transitional) device and transitional
> > > device under one section.
> > >
> > > Some requirements of the transitional device are also located in
> > > legacy interface section which is the right section for it.
> > >
> > > Hence,
> > > 1. Move transitional device requirements to their designated Legacy
> > >    interface section
> > > 2. Describe regular device requirements without quoting it as "non
> > >    transitional device"
> > >
> > > While at it, write the description using a singular object definition.
> > >
> > > This is only an editorial change.
> > >
> > > This patch is on top of [1].
> > >
> > > [1]
> > > https://lists.oasis-open.org/archives/virtio-dev/202302/msg00578.html
> > >
> > > Signed-off-by: Parav Pandit <parav@nvidia.com>
> > 
> > nack I already answered this. legacy sections describe legacy interface of
> > transitional devices.
> > 
> Legacy device id of the transitional device is 0x1000 for net. 
> Legacy revision id of the transitional device is 0x0.
> Why revision id belongs to legacy section, but device id doesn't?
> Still trying to understand this convoluted policy.
> Will re-read your email again if that is explained somehow without bringing the driver in context.

It's convoluted because legacy is convoluted. It's a bolt-on.
We have a modern description. Is says e.g. "A".
Then legacy chapter comes and say "yea but legacy is B".
This is not how spec normally works.


The rule is this: one should be able to ignore legacy
sections if not building a legacy driver/device.

If you are building a modern driver it must support transitional
devices. Thus is must know about id 0x1000.
Conclusion - 0x1000 is out of legacy section.


If you are building a modern driver it ignores revision.
But legacy drivers used revision 0.
So a transitional device has 0 to make legacy drivers work.
Conclusion - revision 0 is in the legacy section.






-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

