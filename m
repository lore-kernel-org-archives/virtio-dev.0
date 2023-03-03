Return-Path: <virtio-dev-return-11413-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F2FFC678D4
	for <virtio-dev@archiver.kernel.org>; Fri,  3 Mar 2023 07:42:57 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 5F3102B055
	for <virtio-dev@archiver.kernel.org>; Fri,  3 Mar 2023 07:42:56 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 42A97986790
	for <virtio-dev@archiver.kernel.org>; Fri,  3 Mar 2023 07:42:56 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 2B70C983E93; Fri,  3 Mar 2023 07:42:56 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-Id: <virtio-dev.lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 17DC0986712
	for <virtio-dev@lists.oasis-open.org>; Fri,  3 Mar 2023 07:42:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: j-v-ShlvOhSH-lXqdALqZA-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677829373;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wp20VkEQGagP9Wr866Bb9r/+6UmTITqcOpcN/M/Y/EA=;
        b=x6xhogji1MkTfF4lRvsM43c+b7fM54tX5meBuU5y9GPC4zuSHplN6vehp+lzWi9F/P
         j4xWEEGMSL2YX1xtr6dSPlrUXQSnxOU+bIN5dJRbKCv9le56lFQtaeqMaX7fs/FSeTEK
         ctTqhOytJKMFnbgpyjeuAjUrslhnTlFihlhRjZf2vljJrCPPD0d3Sm8I/m1ORfZ74C9e
         XQWCv/39hibzEGKHiXsG7CTlCVmmHhZStYTYNnFPW9DGBjeHMHIw1+NG/MxAdgX6KL3G
         Am5VIw1oHpopFtW+0RZCjdn0L0mPuN+WQdPLJrZCZtRB6nmitl4/k6hxgNnhjDTieO3f
         tNeA==
X-Gm-Message-State: AO0yUKUa33pFXe17LOL4lnYD7OlVM4/Tr/gZkY9HGLWzVbeo2egecm7H
	kBvZ7kch/lmhECbf2ooJ9a5hjT439mOC0PXUaqNKgDRVdlZlSS8wjlxx3eQ/2xbtTeaY4CKkIyF
	r/+bFPLQVjjhopJrQlvqnsGEaPtkR
X-Received: by 2002:adf:ffc3:0:b0:2c7:107c:e194 with SMTP id x3-20020adfffc3000000b002c7107ce194mr635518wrs.8.1677829373040;
        Thu, 02 Mar 2023 23:42:53 -0800 (PST)
X-Google-Smtp-Source: AK7set938pJlC8T8LShUCazoAOGkr9F1GRpFiJF1WuKsYQXDxdBHoqPqcHRJVJIrbwjei8D+2q/a1Q==
X-Received: by 2002:adf:ffc3:0:b0:2c7:107c:e194 with SMTP id x3-20020adfffc3000000b002c7107ce194mr635507wrs.8.1677829372751;
        Thu, 02 Mar 2023 23:42:52 -0800 (PST)
Date: Fri, 3 Mar 2023 02:42:49 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Halil Pasic <pasic@linux.ibm.com>, Parav Pandit <parav@nvidia.com>,
	virtio-dev@lists.oasis-open.org,
	virtio-comment@lists.oasis-open.org, shahafs@nvidia.com
Message-ID: <20230303023949-mutt-send-email-mst@kernel.org>
References: <20230223054624.168042-1-parav@nvidia.com>
 <87a60z5wes.fsf@redhat.com>
 <20230301182207.23f995cd.pasic@linux.ibm.com>
 <20230301123044-mutt-send-email-mst@kernel.org>
 <87a60vmbub.fsf@redhat.com>
MIME-Version: 1.0
In-Reply-To: <87a60vmbub.fsf@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [virtio-comment] Re: [PATCH 0/3] Rename queue index to queue
 number

On Thu, Mar 02, 2023 at 04:06:52PM +0100, Cornelia Huck wrote:
> On Wed, Mar 01 2023, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > On Wed, Mar 01, 2023 at 06:22:07PM +0100, Halil Pasic wrote:
> >> On Mon, 27 Feb 2023 09:45:31 +0100
> >> Cornelia Huck <cohuck@redhat.com> wrote:
> >> 
> >> > For the vq index/number, I'm not that sure that "virtqueue number" is
> >> > better that "virtqueue index" -- actually, I'd prefer the latter. We'd
> >> > need some renaming either way.
> >> 
> >> I prefer index as well. Especially that we start indexing with 0. Also
> >> seems to be the more common term for such stuff in both Mathematics and
> >> CS.
> >> 
> >> Regards,
> >> Halil 
> >
> >
> > Basically I am saying that this:
> >
> > /* Queue size for the currently selected queue - Write Only */
> > #define VIRTIO_MMIO_QUEUE_NUM           0x038
> >
> > is a bad name because queue number seems to be ambiguous.
> >
> > Maybe start with just getting rid of uses of QUEUE_NUM meaning size?
> 
> Nod, that seems to be uncontroversial.
> 
> >
> >
> > If we want to use queue index we need to fix RSS spec in networking
> > since that seems to want to use queue index in a very weird way:
> > networking has this idea of calling queues like this:
> > receiveq1 receiveq2 ....
> > why 1-based? I guess we wanted this to be clear even to a 5 year olds ;)
> >
> > And then for extra fun, in the RSS section we say "0 based index" where we
> > seem to mean "this number in the queue name, but subtract 1 in your head".
> > Why subtract 1? I guess we wanted these 5 year olds to practice math ...
> 
> Heh :)
> 
> Yeah, that looks like a mess... I don't think we should use a weird
> substraction scheme. I haven't looked at the RSS stuff much, would it be
> hard to fix it up?

We can't change the ABI, I guess we can say that it's bits 1 to 15
of the VQ number or equivalently VQ number divided
by 2 (it's always an even number for any receiveq).

-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

