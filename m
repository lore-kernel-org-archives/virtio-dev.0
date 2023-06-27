Return-Path: <virtio-dev-return-13105-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1962AEB64D9
	for <virtio-dev@archiver.kernel.org>; Tue, 27 Jun 2023 16:02:55 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 7A7062A8F5
	for <virtio-dev@archiver.kernel.org>; Tue, 27 Jun 2023 16:02:54 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 71009986408
	for <virtio-dev@archiver.kernel.org>; Tue, 27 Jun 2023 16:02:54 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 6321698639B; Tue, 27 Jun 2023 16:02:54 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4A71A986191
	for <virtio-dev@lists.oasis-open.org>; Tue, 27 Jun 2023 16:02:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: fl_tQCWjMAW7tTE7mcXFSw-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687881768; x=1690473768;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2yxQNRras8Ecb/0Swa6SPot1IinJi/ujLEPf7z/8o98=;
        b=NNKDGv550ZxO1Y+tMZUMCLC2SZ98Ux4ofm5xZJjox+8n96xkxdZmfHSSTFhVnBlN6B
         OaxX3oTTYBgXm6IeYhTi0G9wJOQ8yAq0MU53LUMVleU7JZVt/Ole80Fg7/RYCWgbXl07
         9WMxFNWVz3YN2wSww6YMHrP1LhBhPy9cFKasdUvrNJUO04VAksEr9LPfoGpOEzO9125l
         mns5cDHsIIePzmbjWh/mbgrWeSZcbapAcaLdn8ABoEy5GDgFK3mfScDArBbT9dvvC94B
         1vxLTz3oJuWLG0mtGZ7h1NRqe2xiqRfclY7JbIVa79bdxEFKlqOCl6CmhKpyUnuH9J0g
         rxFQ==
X-Gm-Message-State: AC+VfDyBohBoPNIF3Rw4K9Uo7Bl0IHqqbGMK5buMpWhygEyE0Mai6x1q
	jmczuUSo45QY11a3hlvpZOG5ZYABcnRmqCHdyASFPDR9WPE6BJY/7fGk6WYQE7OU9X6uivfQ4ju
	U44M4YY5pjIwxj02t5VjFWIH376vK
X-Received: by 2002:a05:6808:1587:b0:3a1:c979:e6d2 with SMTP id t7-20020a056808158700b003a1c979e6d2mr11152052oiw.35.1687881768771;
        Tue, 27 Jun 2023 09:02:48 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5USTFayXXg/0zanFqmbhaBXw8pXaWTtFnILJ19eDF9ACzZHN3oxG8MngKCYU2iPrDO52ts2w==
X-Received: by 2002:a05:6808:1587:b0:3a1:c979:e6d2 with SMTP id t7-20020a056808158700b003a1c979e6d2mr11152030oiw.35.1687881768519;
        Tue, 27 Jun 2023 09:02:48 -0700 (PDT)
Date: Tue, 27 Jun 2023 12:02:41 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtio-dev@lists.oasis-open.org, parav@nvidia.com,
	virtio-comment@lists.oasis-open.org,
	Jason Wang <jasowang@redhat.com>,
	"Zhu, Lingshan" <lingshan.zhu@intel.com>
Message-ID: <20230627115247-mutt-send-email-mst@kernel.org>
References: <20230626062210.49020-1-xuanzhuo@linux.alibaba.com>
 <1687854185.3344731-3-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <1687854185.3344731-3-xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [virtio-comment] [RFC PATCH] admin-queue: bind the group member
 to the device

On Tue, Jun 27, 2023 at 04:23:05PM +0800, Xuan Zhuo wrote:
> So, this is how I understand the process of creating vf:
> 
> 1. Create a PCI VF, at this time there may be no backend virtio device, or there
>     is only a default backend. It does not fully meet our expectations.
> 2. Create device or migrate device
> 3. Bind the backend virtio device to the vf

I can see this making sense as a feature bit that says VFs are not
initialized by default and must first be setup through an admin command.
This will likely need to be a feature bit because it's changing
behaviour outside of admin commands.

Then, we can have:

	ADMIN_SETUP VF#
	ADMIN_CLEANUP VF#

I like this because this generalizes CREATE/DESTROY that SIOV guys proposed.


Why do we need an id as a level of indirection though? What is wrong
with just using VF# directly?



-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

