Return-Path: <virtio-dev-return-12436-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B86F9C77B78
	for <virtio-dev@archiver.kernel.org>; Wed, 26 Apr 2023 14:57:45 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 98A0C3F56E
	for <virtio-dev@archiver.kernel.org>; Wed, 26 Apr 2023 14:57:44 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 75C0C986653
	for <virtio-dev@archiver.kernel.org>; Wed, 26 Apr 2023 14:57:44 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 52ED098663C; Wed, 26 Apr 2023 14:57:44 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 376C99866DB
	for <virtio-dev@lists.oasis-open.org>; Wed, 26 Apr 2023 14:57:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: hHOqg72HPqi5DNpLQ8diew-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682521060; x=1685113060;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sL74x2Kd/ZqGEkBVhEjGK+CzLLtiwEg2YH4xvojC7NQ=;
        b=X3cXsZWxIOfWV1eYvtDxeo0mPRJi0IXDzSxxTvr2oNJ6X2MZsHEOAfsyLuqaYjjeL5
         Oybhnplm3a9bJkYsY1T6RbttHZXj9XZcupEA0ansgHkX+Zjz8ytD8WQDauPIlqfzMtFh
         a0wkMGWOgfY8Rcx5YjRnwe2ONFH+cKIQ6+Mt35GmZD0ph9l3yCYwEN1v8ggmWw1IeI9v
         OjH7JiStV6bWhmToqCWa73uvBF/VwjuE4NP1stYkMKbHEWWnfHGfTPLscqfMB7qrp0qy
         okNBPAm9S0FFUtIrEuw2SwN5uziqFI/QPqIp8/ja/mzqTZxYRzYZP77+Do41Q1/Ta9uW
         g5aw==
X-Gm-Message-State: AAQBX9dNjTaE8dEu5FkiitrSLcC9acXF4ge+qiMS+zzAmA2PT/wBPu9m
	hLyVNGSm8Ta8VuDq3eRzLLfmadbgKTKSvpXnuzAY/Ryiw32wdzODLYfMEXEadF6mRYfrtV9TW+x
	2Ydnjv69Ae4ur8XrMnFBG3fxriif0
X-Received: by 2002:a5d:58e9:0:b0:2f6:1a30:605c with SMTP id f9-20020a5d58e9000000b002f61a30605cmr15226559wrd.3.1682521060606;
        Wed, 26 Apr 2023 07:57:40 -0700 (PDT)
X-Google-Smtp-Source: AKy350YQoM9BysARWMa4ZYHAu7D5A2pY5cO2NGNB3mjFmlAhmJiIVetNrLXp7+OBT3uVbDAEHapv/A==
X-Received: by 2002:a5d:58e9:0:b0:2f6:1a30:605c with SMTP id f9-20020a5d58e9000000b002f61a30605cmr15226541wrd.3.1682521060276;
        Wed, 26 Apr 2023 07:57:40 -0700 (PDT)
Date: Wed, 26 Apr 2023 10:57:36 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: Heng Qi <hengqi@linux.alibaba.com>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	Jason Wang <jasowang@redhat.com>,
	Yuri Benditovich <yuri.benditovich@daynix.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Message-ID: <20230426104902-mutt-send-email-mst@kernel.org>
References: <20230423073532.105636-1-hengqi@linux.alibaba.com>
 <f9221063-8419-9cb3-e59c-0b0393bdd501@nvidia.com>
 <ced8a6f0-7858-0b0a-55bb-26eea2a7ff5a@linux.alibaba.com>
 <PH0PR12MB5481EA937633233A9A9E5E30DC659@PH0PR12MB5481.namprd12.prod.outlook.com>
 <1d0adb7d-fcc8-404d-8105-bc1f818bc3a3@linux.alibaba.com>
 <PH0PR12MB54817E0B2B0B232B49320F5CDC659@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB54817E0B2B0B232B49320F5CDC659@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Subject: [virtio-dev] Re: [virtio-comment] RE: [PATCH v13] virtio-net: support inner
 header hash

On Wed, Apr 26, 2023 at 02:24:48PM +0000, Parav Pandit wrote:
> 
> 
> > From: Heng Qi <hengqi@linux.alibaba.com>
> > Sent: Wednesday, April 26, 2023 10:04 AM
> 
> > Yes, but that seems like a tiny cost, and the cvq command-related structure is
> > much simpler.
> Current structure size is 24 bytes.
> This size becomes multiplier with device count scale to be always available and rarely changes.
> 
> As we add new features such device capabilities grow making the multiplier bigger.
> For example 
> a. flow steering capabilities (how many flows, what mask, supported protocols, generic options)
> b. hds capabilities
> c. counter capabilities (histogram based, which error counters supported, etc) 
> d. which new type of tx vq improvements supported.
> e. hw gro context count supported
> 
> May be more..

All these are ROM though. Can be shared between functions on a single
device, be it VFs or multifunction PF. Yea I heard you about
maybe making them programmable. For some cases where there is a
hardware resource associated with it, it makes sense.
Not in this case though, it's just another way to calculate hash.


> Depending on the container/VM size certain capabilities may change from device to device.
> Hence it is hard to deduplicate them at device level.
> 
> Therefore, ability to query them over a non_always_available transport is preferred choice from the device.
> 
> A driver may choose to cache it if its being frequently accessed or ask device when needed.
> Even when it's cached by driver, it is coming from the component that doesn’t have transport level timeouts associated with it.

well caching by driver is using up same amount of RAM, only with no
chance to 

-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

