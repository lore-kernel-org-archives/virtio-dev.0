Return-Path: <virtio-dev-return-11427-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF432C6FA8E
	for <virtio-dev@archiver.kernel.org>; Sun,  5 Mar 2023 09:29:11 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id DD72644346
	for <virtio-dev@archiver.kernel.org>; Sun,  5 Mar 2023 09:29:10 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C7CD6986490
	for <virtio-dev@archiver.kernel.org>; Sun,  5 Mar 2023 09:29:10 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id B449698638A; Sun,  5 Mar 2023 09:29:10 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-Id: <virtio-dev.lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 9F06598638B
	for <virtio-dev@lists.oasis-open.org>; Sun,  5 Mar 2023 09:29:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: X3e3k5VwPO-oUQOMJboiYw-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678008547;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7A1nq8VGuQsXweiMK2QfeEgJbdHdU65M76KXyqZ8PRk=;
        b=ALEUPHN5g4XQS00zWYoIbrOi0qYqjWJERqOlWg/YBqt495KNMvCy8tpI9Ru4WuYKn7
         TtaJorsX7lXrF0uoyQmw89T8r1p4IaWu+N2/zUKIa7SDrVFe58yt8RSpY2GzV9gK+EE6
         TdDfpa7/8KZUEblJDci3a9OpxIHx06MDz+B2KPOA7l4Itv71bXWHFkXgWX0j18+A44Yi
         cOtgtr2y04r+WvI1cxTXkPTXJA99gM5Jp6o+6dtYNpxrCVAaryMVQBaGu6m/abAcJkfj
         KI3XLiAlsIzIdzn+SXtH4BeLjIYcgE2riqcQxkmdmcRbFckEigGKzL+fv46F6i4xKqGS
         ti9w==
X-Gm-Message-State: AO0yUKXmfekFe+o74BHzG0JMMHOVSgCdxlVz4nHB4caBDXKyDvwKT9fR
	esviUrQlj40x4qy45Q8zDV1SvJF6ZYUHfPPr2/SrAPWJQne+VkH1/9MIUJYg25q74mOsnkfEP2x
	S8SGrpfsj0sgT0cswU4Tp072hAxLJ
X-Received: by 2002:a05:600c:198e:b0:3e2:1ef0:f585 with SMTP id t14-20020a05600c198e00b003e21ef0f585mr6213080wmq.2.1678008547448;
        Sun, 05 Mar 2023 01:29:07 -0800 (PST)
X-Google-Smtp-Source: AK7set95gBEysW8zbi5RprgVtnBlzXGMoNwJAbkXC1zsgymJSI0vC3TgKziw/Dv2IMDGO1TOYQyqrQ==
X-Received: by 2002:a05:600c:198e:b0:3e2:1ef0:f585 with SMTP id t14-20020a05600c198e00b003e21ef0f585mr6213070wmq.2.1678008547151;
        Sun, 05 Mar 2023 01:29:07 -0800 (PST)
Date: Sun, 5 Mar 2023 04:29:03 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Halil Pasic <pasic@linux.ibm.com>
Cc: Parav Pandit <parav@nvidia.com>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"cohuck@redhat.com" <cohuck@redhat.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	Shahaf Shuler <shahafs@nvidia.com>,
	Yuri Benditovich <yuri.benditovich@daynix.com>
Message-ID: <20230305042501-mutt-send-email-mst@kernel.org>
References: <20230223054624.168042-1-parav@nvidia.com>
 <20230227123751-mutt-send-email-mst@kernel.org>
 <20230302165216.1293d066.pasic@linux.ibm.com>
 <PH0PR12MB54810632DAE7C0D8BEABC9E9DCB29@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230303163802.588dfbb0.pasic@linux.ibm.com>
MIME-Version: 1.0
In-Reply-To: <20230303163802.588dfbb0.pasic@linux.ibm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [virtio-comment] Re: [PATCH 0/3] Rename queue index to queue
 number

On Fri, Mar 03, 2023 at 04:38:02PM +0100, Halil Pasic wrote:
> On Thu, 2 Mar 2023 16:12:48 +0000
> Parav Pandit <parav@nvidia.com> wrote:
> 
> > > >
> > > > is the index same as vq number? or something different?  
> > > 
> > > It is something different. The full paragraph sound like this
> > > 
> > > """
> > > Field \field{unclassified_queue} contains the 0-based index of the receive
> > > virtqueue to place unclassified packets in. Index 0 corresponds to receiveq1.
> > > """  
> > With vqn it can be as simply written as.
> > Field \field{unclassified_queue} contains the receive virtqueue number to use for unclassified incoming packets.
> > 
> > Similarly rss description can be simplified.
> 
> But that would change the semantics of the interface (and the ABI). And
> we really should refrain from that.
> 
> We could also say 
> 
> Field \field{unclassified_queue} contains the 0-based index of the receive
> virtqueue to place unclassified packets in. Index N corresponds to receiveqN
> and thus to virtqueue index 2N.
> Provided that we decide to change the naming of the receive queues so
> that receiveqN becomes receiveqN-1, and provided that we go with the
> virtqueue index and not with the virtqueue number wording.

This has a decent chance to confuse a lot of people.
E.g. if someone wrote "receiveq1" in their code comments,
now this suddenly refers to a different queue.

> We could also just drop the name and just say that it corresponds to the
> virtqueue index 2N like Michael has pointed out. But I would prefer the
> former.
> 
> Regards,
> Halil

I proposed virtqueue number not virtqueue index because we
said index in the past to mean N+1.
Or even better some new term.

-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

