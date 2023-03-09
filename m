Return-Path: <virtio-dev-return-11581-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E634FC64EC4
	for <virtio-dev@archiver.kernel.org>; Thu,  9 Mar 2023 16:53:42 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 0ED492B070
	for <virtio-dev@archiver.kernel.org>; Thu,  9 Mar 2023 16:53:42 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id EBAAB986701
	for <virtio-dev@archiver.kernel.org>; Thu,  9 Mar 2023 16:53:41 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id D6C9E98650A; Thu,  9 Mar 2023 16:53:41 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C45D69866FB
	for <virtio-dev@lists.oasis-open.org>; Thu,  9 Mar 2023 16:53:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: bkRlA6VDOl2TiH24s8U2ug-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678380818;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sUMv+BQZZG0bXbwaHh0UMk4InwdMHaib1FIqCOqa1KU=;
        b=fwiQVLtDypd7FA4tPrt2WjF7kkiaOFB/gUVWFLm9egzBHBtwL+W6OeOCsfQGNp/qLR
         xcsyLypKM70SC3ywcmN4siNatdCauU9ZNsnvlPudw1ecG54uxZdJx6+D5SZEBQvMJzEv
         SoJcL+ZyOQfByfFBae501cw7YflBoYuTEY3AkJPdF7A/0xLKkMwZKmI4UxUC8tQSsz3Q
         5eJF0MFg2A4kZZMkN83m81N9i5D3EOyjOrN1bKItgCvl2lYaf765K11li/Wvw4E2XbX4
         +RPAZ8E3Qp4g3PlctZd6lSgYQnByrbkR2ICCyZIsj+0dgs9cxnA/n4ZvjVPnymciMadr
         IUYw==
X-Gm-Message-State: AO0yUKUz1gw8WE+a6vqvgjg/64p/ayEL/iatQ8AMsFGveJNknzFi/mWd
	SGFN6zME/EpszTOXp1EE9yuNXjYj8seQbmIOtA7s48PeFS3EVtVG2v1W8RbCQrpSBBYAdsFWTup
	mCLuGw30d//I7C1Y6I1gLgbHaf0g0
X-Received: by 2002:adf:e543:0:b0:2c7:d7c:7d0 with SMTP id z3-20020adfe543000000b002c70d7c07d0mr18002131wrm.22.1678380818565;
        Thu, 09 Mar 2023 08:53:38 -0800 (PST)
X-Google-Smtp-Source: AK7set+teVU5PTdZ6uHa8U8q8gJ00kaNnMkcFJltwYhF7bbjiu+5N/kx8ChjuT0X3ElifWXnH3n0+Q==
X-Received: by 2002:adf:e543:0:b0:2c7:d7c:7d0 with SMTP id z3-20020adfe543000000b002c70d7c07d0mr18002119wrm.22.1678380818302;
        Thu, 09 Mar 2023 08:53:38 -0800 (PST)
Date: Thu, 9 Mar 2023 11:53:34 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Halil Pasic <pasic@linux.ibm.com>
Cc: Cornelia Huck <cohuck@redhat.com>, Parav Pandit <parav@nvidia.com>,
	virtio-dev@lists.oasis-open.org,
	virtio-comment@lists.oasis-open.org, shahafs@nvidia.com
Message-ID: <20230309115110-mutt-send-email-mst@kernel.org>
References: <20230223054624.168042-1-parav@nvidia.com>
 <87a60z5wes.fsf@redhat.com>
 <20230301182207.23f995cd.pasic@linux.ibm.com>
 <20230301123044-mutt-send-email-mst@kernel.org>
 <87a60vmbub.fsf@redhat.com>
 <20230303023949-mutt-send-email-mst@kernel.org>
 <20230303224937.62fe64b9.pasic@linux.ibm.com>
 <20230305043948-mutt-send-email-mst@kernel.org>
 <20230309174650.7093f020.pasic@linux.ibm.com>
MIME-Version: 1.0
In-Reply-To: <20230309174650.7093f020.pasic@linux.ibm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: Re: [virtio-dev] Re: [virtio-comment] Re: [PATCH 0/3] Rename queue
 index to queue number

On Thu, Mar 09, 2023 at 05:46:50PM +0100, Halil Pasic wrote:
> To uniquely identify an element we need both the index (a value) and
> the array/table that is being indexed. And I believe this is what we
> need to improve on. I don't think calling indexes into the conceptual
> array of receive queues (or receive virtqueues) "index of the receive
> virtqueue", indexes into the conceptual array of virtqueues that belong
> to a certain device a "vq number", indexes into the descriptor table
> "descriptor keys", and indexes into the used rings "used ring element
> ids" would really help -- to make an attempt at using reduction ad
> absurdum ;)

Right.  I think Parav said he's converting everything to just refer
to "VQ number".


> 
> 
> > I feel there's less of a chance of a confusion between VQ size and
> > its number. But it's not a strong prefrence, RSS is relatively young
> > and it's the only incompatible user of index so far.
> 
> I don't understand why is RSS incompatible with "index".
> 
> Regards,
> Halil

It uses the word "index" in a way that is different from what you
suggest.

Anyway, both "number" and "index" require cleanup work, whoever
is going to do it gets to decide which way it will go.

-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

