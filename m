Return-Path: <virtio-dev-return-13350-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BD56EB64DA
	for <virtio-dev@archiver.kernel.org>; Wed, 12 Jul 2023 12:35:30 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id ECE331CA244
	for <virtio-dev@archiver.kernel.org>; Wed, 12 Jul 2023 12:35:29 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D06D8986687
	for <virtio-dev@archiver.kernel.org>; Wed, 12 Jul 2023 12:35:29 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id B68EC986663; Wed, 12 Jul 2023 12:35:29 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A020A986682
	for <virtio-dev@lists.oasis-open.org>; Wed, 12 Jul 2023 12:33:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: HtCMJUN3Oe-y4eACXJMx7w-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689165232; x=1691757232;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hxINkLs/aDtZ0YVMsrTCgVbM8Gy5bxAOvp6IiY4q+KA=;
        b=ja0hUQ4GJUP28eT7pxb8nOkkeUuhR2U0kBmtdVWhJS6XccJrSjzfcjtSfWwpx+4YuE
         Y18I+D3verktvlYMkh1YAv9VCnegUpXZi7dVJoVo4xIAtKpDBnjWcunhYtAAf/2Tajxn
         x4w/Uuv+03JdaYCNO9xpqHaIytpwsCuaZ7zj50493vowtcy+EpVujfPfzVGhazocg+UY
         8yGTW9v+KYPTKl2wpDiU2nHQfi8Cfc+H7GUP19IXitKDFolWnk+e5SDl9ehcZQ+9jqxm
         jaQQ8jy5pEzLp6uLM2dSOE7wMofZi/YAqGlcSUi+lNnAD1oeimHEmpVbKlZ3M84v8Nfh
         QGBA==
X-Gm-Message-State: ABy/qLZ+nE95fJCJFlIT3MU8UgkEQ1sG6fwEvKvC01FYLUSEXr3hK+LB
	ge0FwMncysoEVHGW/pWaLmIQ5nhp8xhJf2Dbpy9Y0IbQAu1wHttfVzOJgmL2/TwXFzub5a2+Xvc
	cN6lw5Q1OJH/LoAXbNXmUqRSLXqDL
X-Received: by 2002:a5d:6b4c:0:b0:313:f7bd:f0 with SMTP id x12-20020a5d6b4c000000b00313f7bd00f0mr18781166wrw.49.1689165232387;
        Wed, 12 Jul 2023 05:33:52 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEBOBBeGwChu/QsDZ9iR6CMgQ/NAxUzBP3Zlm8OT27QlXi5T5DVdtc3Z71JeHCED+46/cbWpA==
X-Received: by 2002:a5d:6b4c:0:b0:313:f7bd:f0 with SMTP id x12-20020a5d6b4c000000b00313f7bd00f0mr18781145wrw.49.1689165232051;
        Wed, 12 Jul 2023 05:33:52 -0700 (PDT)
Date: Wed, 12 Jul 2023 08:33:47 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, virtio-dev@lists.oasis-open.org,
	jasowang@redhat.com, Parav Pandit <parav@nvidia.com>
Message-ID: <20230712082616-mutt-send-email-mst@kernel.org>
References: <20220315032402.6088-1-xuanzhuo@linux.alibaba.com>
 <20230712072050-mutt-send-email-mst@kernel.org>
 <1689162241.4383667-1-xuanzhuo@linux.alibaba.com>
 <20230712075319-mutt-send-email-mst@kernel.org>
 <87mt01jp1b.fsf@redhat.com>
MIME-Version: 1.0
In-Reply-To: <87mt01jp1b.fsf@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: Re: [virtio-dev] Re: [PATCH v12] virtio-net: support device stats

On Wed, Jul 12, 2023 at 02:24:32PM +0200, Cornelia Huck wrote:
> On Wed, Jul 12 2023, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > On Wed, Jul 12, 2023 at 07:44:01PM +0800, Xuan Zhuo wrote:
> >> On Wed, 12 Jul 2023 07:34:38 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> >> > On Tue, Mar 15, 2022 at 11:24:02AM +0800, Xuan Zhuo wrote:
> >> > > This patch allows the driver to obtain some statistics from the device.
> >> > >
> >> > > In the back-end implementation, we can count a lot of such information,
> >> > > which can be used for debugging and judging the running status of the
> >> > > back-end. We hope to directly display it to the user through ethtool.
> >> > >
> >> > > To get stats atomically, try to get stats for all queue pairs in one
> >> > > command.
> >> > >
> >> > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> >> > > Suggested-by: Michael S. Tsirkin <mst@redhat.com>
> >> >
> >> > Functionally, I think this is close to ok now.  But the text needs
> >> > of work.  Are you trying to target 1.3 with this?
> >> 
> >> I personally worry about that 1.3 may be too late, if possible, I would like to
> >> respond as soon as possible.
> >> 
> >> I really don't really care if it can get into 1.3 or not but I do hope that this
> >> can be done as soon as possible.
> >> 
> >> Thanks.
> >
> > Yes we were supposed to freeze for 1.3. This change can be merged on a
> > main branch after 1.3 forks and is under review.
> 
> Nod, that's what I would prefer to do. Being merged on virtio-next
> should be enough for including device/driver implementations.

Except I'd prefer a v1.3 branch instead of a next branch - adding things
on the branch should be harder, not easier.

-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

