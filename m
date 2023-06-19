Return-Path: <virtio-dev-return-12958-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AF4CEB64D9
	for <virtio-dev@archiver.kernel.org>; Mon, 19 Jun 2023 14:21:03 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 3C30D71C8A
	for <virtio-dev@archiver.kernel.org>; Mon, 19 Jun 2023 14:21:03 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 18B3498640E
	for <virtio-dev@archiver.kernel.org>; Mon, 19 Jun 2023 14:21:03 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 02B5A986399; Mon, 19 Jun 2023 14:21:03 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E268598639E
	for <virtio-dev@lists.oasis-open.org>; Mon, 19 Jun 2023 14:21:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: hwtWhfWtP-K-VtxgGGeeLA-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687184459; x=1689776459;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6sM3jxiubmf9y/gQYslRwopcHKnmPXCUqfZhxhyaAe0=;
        b=FObzuz/pFO7gZzsOTJNXB5ykNcuCQjUDhxb221flnfVCLaROWa6aVySOhMqlPz72Gs
         MgFOx1IPBvYqYBslpTNh3iESEBFXRK4ArbOl4rjDnL1TbSbaqZNUzDPrETRc5Rluj2gg
         R0TcSLGTZ3gEparvbs+lc8QouLNa9pNuSSEm0oNqp5PtK/e/3QLsWM9ZX9oYjEgAEn/a
         GouiRmzxfrOKewqJrA/doih0MZvlba04pW4bjGoUmnz0LYOgqCcMelm4pE6Nr5DQiSrV
         kzpwZsuqH9+cr8Hz2oFPARDZaykkp2Bv+fRCy69cZa2H+A7RpOhFqsQpcK0j79t2uO13
         eFwg==
X-Gm-Message-State: AC+VfDyb4AFlDexENVOPTyHU1r7HYZm3nt8lRrQ4yCBpbJ3DHmfyP3XL
	bZvne1paus3U7E+j9G5JoP5Ma+/c3bIBDATHEu5dleyEGbT8wsjSdC2QFCztCPaWojTBeQAs9iK
	9/n7E4fWgxkkwh+vsrNtQUcOpoMaE
X-Received: by 2002:a05:600c:2206:b0:3f9:515:ccfb with SMTP id z6-20020a05600c220600b003f90515ccfbmr7130918wml.12.1687184459748;
        Mon, 19 Jun 2023 07:20:59 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5NL8nqhtb2xaY1AziECob7VG+hmylPPztoXz/DI5h5QKmlAelmBWEWAXPTG7XT1PyeLkrK3Q==
X-Received: by 2002:a05:600c:2206:b0:3f9:515:ccfb with SMTP id z6-20020a05600c220600b003f90515ccfbmr7130900wml.12.1687184459400;
        Mon, 19 Jun 2023 07:20:59 -0700 (PDT)
Date: Mon, 19 Jun 2023 10:20:56 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	Jason Wang <jasowang@redhat.com>
Message-ID: <20230619101745-mutt-send-email-mst@kernel.org>
References: <1686550355.2503424-1-xuanzhuo@linux.alibaba.com>
 <20230612022526-mutt-send-email-mst@kernel.org>
 <1686569235.2395291-1-xuanzhuo@linux.alibaba.com>
 <20230613045854-mutt-send-email-mst@kernel.org>
 <1686810211.4567776-1-xuanzhuo@linux.alibaba.com>
 <20230616101113-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481D058584D7AF742C1FEE1DC5FA@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB5481D058584D7AF742C1FEE1DC5FA@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [virtio-comment] Re: About custom device counter

On Mon, Jun 19, 2023 at 12:33:33PM +0000, Parav Pandit wrote:
> 
> 
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Friday, June 16, 2023 10:13 AM
> > > Such as "limit", in a cloud scenario, multiple users purchase
> > > different VMs, and these VMs share the capabilities of the same host.
> > > In order to ensure that each VM will not affect others, the network
> > > card(virtio-net) capability of each VM is limited. When these users purchase
> > VMs, this limit has already been determined.
> > > So if the network card traffic of a vm exceeds the upper limit, packet
> > > loss will occur. It is necessary for us to count these packet losses.
> > > And the device should expose to the user.
> > 
> > OK so here, driver is expected to rate limit yes?
> > 
> Some implementations of txq are lossy and some are not creating backpressure/flow control to driver so driver can rate limit it naturally.
> So a tx packet drop counter is needed to cover the lossy implementations which is abstract enough regardless of reason on why device dropped it.


Yes but Xuan Zhuo here is saying that he wants a register that is
like link speed, not a counter.


> A more granular counter becomes vendor specific that we can possibly avoid or place under different command.


-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

