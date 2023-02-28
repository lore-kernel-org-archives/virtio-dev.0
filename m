Return-Path: <virtio-dev-return-11335-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D02ABC7EE2E
	for <virtio-dev@archiver.kernel.org>; Tue, 28 Feb 2023 11:17:02 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 0D2CC2A88B
	for <virtio-dev@archiver.kernel.org>; Tue, 28 Feb 2023 11:17:02 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 03FB3986624
	for <virtio-dev@archiver.kernel.org>; Tue, 28 Feb 2023 11:17:02 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id ED35A9865FA; Tue, 28 Feb 2023 11:17:01 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-Id: <virtio-dev.lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D8FF7986601
	for <virtio-dev@lists.oasis-open.org>; Tue, 28 Feb 2023 11:17:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: N1ivNJDHMSSRr_9MnelFMg-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677583015;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oUlwg9Cfd16D4Ky7HVKIJj9ryi6beyue9OG3PP96gEo=;
        b=er8Uc2QhadLM6gXULd2wBwMRRP7nCGF72pSmAVDW62C+5/rVHkJbDL7ZHAQRAPNol+
         weCvp6FxlnsNNpcHi7e7y9JnlJHn20//5OetPqnjjhKheHJPebn6ZCI2aLZHT0shKeDF
         CXpgzEQIxBYnEwRxkka/kDwShcO+HaXOlPd6oYAmvFnqX16dNenAMcMyaY7oMkpHAzor
         t7EoBiD2mDebW/GbbuQwWpq4I3Kf9pLhMX1e8zhlg/gUobpgeamqJ52V8zvZ0/6cNyDA
         IGNSMzXbpGI8zA8usY2LZVNdifjElGaVfiQrFKgb6ric3mrjd7eBXT379h9P/vWXn7yd
         NDwg==
X-Gm-Message-State: AO0yUKV/SJ3zLfIuZlcWnE6KDhaITgbn7i1Z3bpt10Z0FUF/XFzzFtqw
	rmVYcW3nTAsws0r9g21FxJnNojbIyr3SVa9cXd9Nc+k5SKVf12vQgQINpbiWG21HJObhAoyZF1v
	2ClrCOxVz6Wc0vu6K3mYf76h03BUW
X-Received: by 2002:adf:fdd2:0:b0:2c8:b9cb:885e with SMTP id i18-20020adffdd2000000b002c8b9cb885emr1396177wrs.24.1677583015124;
        Tue, 28 Feb 2023 03:16:55 -0800 (PST)
X-Google-Smtp-Source: AK7set/yapztiY3wDxblEn0c87V0wYjQPt5JgYiwPoOR1mbLPOnTcghhWRvLaYbJ40K3UVaQCGFTGg==
X-Received: by 2002:adf:fdd2:0:b0:2c8:b9cb:885e with SMTP id i18-20020adffdd2000000b002c8b9cb885emr1396166wrs.24.1677583014824;
        Tue, 28 Feb 2023 03:16:54 -0800 (PST)
Date: Tue, 28 Feb 2023 06:16:51 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org,
	Parav Pandit <parav@nvidia.com>, Jason Wang <jasowang@redhat.com>,
	Yuri Benditovich <yuri.benditovich@daynix.com>,
	Cornelia Huck <cohuck@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Message-ID: <20230228061309-mutt-send-email-mst@kernel.org>
References: <20230218143715.841-1-hengqi@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <20230218143715.841-1-hengqi@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [PATCH v9] virtio-net: support inner header hash
Message-ID: <20230228111651.Zq-AsD-3tZYHUsIBwHLtMlE0slZL2kJZGvoHUbu_gfM@z>

On Sat, Feb 18, 2023 at 10:37:15PM +0800, Heng Qi wrote:
> If the tunnel is used to encapsulate the packets, the hash calculated
> using the outer header of the receive packets is always fixed for the
> same flow packets, i.e. they will be steered to the same receive queue.

Wait a second. How is this true? Does not everyone stick the
inner header hash in the outer source port to solve this?
For example geneve spec says:

   it is necessary for entropy from encapsulated packets to be
   exposed in the tunnel header.  The most common technique for this is
   to use the UDP source port

same goes for vxlan did not check further.

so what is the problem?  and which tunnel types actually suffer from the
problem?

-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

