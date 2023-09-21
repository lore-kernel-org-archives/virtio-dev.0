Return-Path: <virtio-dev-return-13909-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7868FCD4958
	for <virtio-dev@archiver.kernel.org>; Thu, 21 Sep 2023 06:07:05 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id AE45A217C7
	for <virtio-dev@archiver.kernel.org>; Thu, 21 Sep 2023 06:07:04 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 89037986687
	for <virtio-dev@archiver.kernel.org>; Thu, 21 Sep 2023 06:07:04 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 6FF5898667C; Thu, 21 Sep 2023 06:07:04 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5F5B398667D
	for <virtio-dev@lists.oasis-open.org>; Thu, 21 Sep 2023 06:07:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: YvEP48PNPNyQW-p-lGvfCQ-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695276420; x=1695881220;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nMbIoUhYxhya0W7LWEcL7vXAJhy58l1saPcs+IPggHI=;
        b=m1HrdfOLXKjyQ4Suxlc9WfO0alI9gJ+yOOZ8wgInQIcrAj8CWVx7jdon0+6+mdOUFC
         nmQAg+6pIQ7W0DayHZ5YBb+bOfXEnUkK/gIWcI46temghodwT73wPNJKBqzR95RLW1/3
         IeTuK0EXqaO/hRc7igsljQ792jKGMt1NjPkNwPD5QshH9jyVkHWqLvy4RV9XTfc/qUn2
         D5wVr1XMlshaHjrai5bOg8YeFXfoxTwDfu7y7vlb28ZZXwr8eVFyew1i7Lgp5rDZp9nf
         ty78uVBwU7MaXjHqSLmbFnPMni4+QcUxHxl/hT+32zpkXm/AqnBEgk0+AFlYYhDfMY+K
         trPA==
X-Gm-Message-State: AOJu0Yx+BqaxhvsGB1XYfVaBOSzlhaLq8VdOiCs3TLRL0lzVJlGly85k
	0j3I8zwImc+vdMKtjoDCqu6fnFXfjEUTMTTZRTLRRTeaTdjzMvqTHqjjpUQ46dXcIjlrwxXXeKK
	Df+UUI9L3V6tZ2u3+NUhS3eO++Qg/
X-Received: by 2002:a17:906:76c2:b0:9ae:5270:46d5 with SMTP id q2-20020a17090676c200b009ae527046d5mr2667890ejn.73.1695276419764;
        Wed, 20 Sep 2023 23:06:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEjYeoT3czo55CKBEyJbgEQR3C7Ta9nQy15tOITkYAo/rQq1pEwtdx1CQSOTdPaxDPPdkv7tg==
X-Received: by 2002:a17:906:76c2:b0:9ae:5270:46d5 with SMTP id q2-20020a17090676c200b009ae527046d5mr2667866ejn.73.1695276419391;
        Wed, 20 Sep 2023 23:06:59 -0700 (PDT)
Date: Thu, 21 Sep 2023 02:06:54 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: "Zhu, Lingshan" <lingshan.zhu@intel.com>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	Jason Wang <jasowang@redhat.com>
Message-ID: <20230921015810-mutt-send-email-mst@kernel.org>
References: <2f67fb85-2238-9c34-a265-b0f97b7ab7e1@intel.com>
 <20230920075243-mutt-send-email-mst@kernel.org>
 <20230920084058-mutt-send-email-mst@kernel.org>
 <PH0PR12MB548110E53C924C984FA24A49DCF9A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230920101402-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54816F8341A77E63831316DBDCF9A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230920160218-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54814A89793CF796412D6A27DCF8A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230921004957-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481E096E0298F29C9EA73B4DCF8A@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB5481E096E0298F29C9EA73B4DCF8A@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: Re: [virtio-dev] Re: [PATCH 0/5] virtio: introduce SUSPEND bit and
 vq state

On Thu, Sep 21, 2023 at 05:54:37AM +0000, Parav Pandit wrote:
> Hi Michael,
> 
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Thursday, September 21, 2023 11:12 AM
> 
> > I was attempting to have each of you see other's point of view.
> > It seems clear I was right, at least one way communication was not getting
> > through. Let me try to help.
> > 
> > 
> > First, clearly Zhu Lingshan cares about the mediation use-case, not the un-
> > mediated one.  Mediation is clearly heavier but also more powerful in many
> > use-cases - is that obvious or do I need to list the reasons?
> 
> I agree to it.
> 
> > To mention one example, it supports cross-vendor migration. Which the
> > unmediated variant maybe can in theory support too, and when it does maybe
> > in a better and more structured way - but that will require standartization effort
> > that didn't happen yet. With mediation it was already demonstrated more than
> > once.
> >
> We should be enhancing the device context so that more and more items can be annotated.
> I started with small to get the design and idea through and will expand the device context so that cross vendors can migrate.

As I said, doable without mediation but already done with.


> > 1. For mediation something that works within existing mediation framework -
> > e.g. reusing as he does feature bits - will require less support than a completely
> > separate facility.
> > I think Zhu Lingshan also believes that since there will be less code -> less
> > security issues.
> >
> With approach of [1], there is less code in the core device migration flow because none of those fields etc are parsed/read/written by the driver software.

What is or is not executed in a specific flow is a separate question.
But the point is vdpa and any mediation have to talk virtio things
such as feature bits. So reusing e.g. feature bits needs less code
than operating the admin command machinery to check what is
supported. Yes, you can operate this machinery during setup
and not during migration itself. It's still less code to maintain.


> > 2. With or without mediation, the mapping of commands to VFs is simpler,
> > allowing more control - for example, let's say you want to reset a VF - you do not
> > need to flush the queue of existing commands, which might potentially take a
> > long time because some other VFs are very busy - you just reset the VF which
> > any unmap flow will already do.
> > 
> If I understand you right, to reset a VF, no need to flush the queues without mediation too.
> Just do VF FLR or do device reset, both will be fine.

Not to reset the VF - that's a narrow definition. To put it back in its
original state unrelated to any VMs.  Nope, FLR is not enough - there
could be commands in queue addressing the VF. If they take effect after
FLR VF state changed and it can't be cleanly assigned to a new VM.


> > 
> > 
> > But Zhu Lingshan, all this will be pointless if you also do not try to do this and list
> > what are reasonable points that Parav made. Please do not mistake what I'm
> > doing here for taking sides I just want the communication to start working. And
> > that means everyone tries to take all use-cases into account even if working for
> > a vendor that does not care about this use-case. Otherwise we will just keep
> > getting into these flamewars.
> 
> Right. I like to take this opportunity to ask again, lets sit together and see if we can utilize common framework between two methods.
> For example,
> 1. device context for mediation and without mediation can provide common structures that both solutions can use
> 2. device provisioning (not in any of our series, that can find common ways)
> 
> May be more can be merged once we are open to collaborate.
> If we face technical issues in unifying the methods, it will be self-explained why both methods to exist or create something different for two different use cases.


-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

