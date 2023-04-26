Return-Path: <virtio-dev-return-12435-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1B7CC77B7C
	for <virtio-dev@archiver.kernel.org>; Wed, 26 Apr 2023 14:48:29 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id DBD5A2A82D
	for <virtio-dev@archiver.kernel.org>; Wed, 26 Apr 2023 14:48:28 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id CC961986651
	for <virtio-dev@archiver.kernel.org>; Wed, 26 Apr 2023 14:48:28 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id C172A98663F; Wed, 26 Apr 2023 14:48:28 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B064D986641
	for <virtio-dev@lists.oasis-open.org>; Wed, 26 Apr 2023 14:48:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: 623Q3bUsP4OI1SkcUe4fNg-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682520503; x=1685112503;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ve1mOtApOnhEOenL2QGx6emFuQaZ2z0brK6Z6sVEO98=;
        b=KgOVC4/lm2DJWd1bk1VUG3Q0UZgtF2L3PhT/MWhprOjyg3TXyq50MtlFldxeMkZ8xl
         jUIdb/gTa+1deZ5/QJ51LLJilFwCFvkozdrIzQc9LJYkxH7GnlL/vnLR5OCuE1gp2Whc
         aiaqLwWSuGL4SFQ6YwfS+55oBcO4NldbFlILS2t0xU7NOreULHrSMFAfquc+6Kfbfx6h
         KTP6fc5YqMQN6nkGLf3Iac92I9xIikPo3ylWa3FVqlpWk6HzJPoSdZyxAHPwIpQ7YbPd
         EtQVQpqV0aoq4/qAPwCTQ/MJ3hiDwL8VD75Vhn0V03GRt10vWo1m2B7XbYuJb0DDQquB
         wtZg==
X-Gm-Message-State: AAQBX9d50njcpzTLM2Zn3/SB+/LDFF12vW0eioqgP0jnabD3Fs5ah6JF
	vTOY9FkQTs6SW6AiiiJHV15Qt1D/fJ4w+NMKF5msOH0+SSOnvwb67phi2502D2owfTPCvATwYRR
	WngywIZ3Rw7+UrHlk2BX40vUej/MP
X-Received: by 2002:a1c:7c0a:0:b0:3f0:b095:15d9 with SMTP id x10-20020a1c7c0a000000b003f0b09515d9mr12489384wmc.40.1682520503759;
        Wed, 26 Apr 2023 07:48:23 -0700 (PDT)
X-Google-Smtp-Source: AKy350Y0bh+R+DkT96go/U9iKlprf1h5/06irPoHjbMvBI0EWPM7kpUo30CHi7o6RaR7hs3RSAkasA==
X-Received: by 2002:a1c:7c0a:0:b0:3f0:b095:15d9 with SMTP id x10-20020a1c7c0a000000b003f0b09515d9mr12489368wmc.40.1682520503439;
        Wed, 26 Apr 2023 07:48:23 -0700 (PDT)
Date: Wed, 26 Apr 2023 10:48:20 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: virtio-dev@lists.oasis-open.org, virtio-comment@lists.oasis-open.org,
	Parav Pandit <parav@nvidia.com>, Jason Wang <jasowang@redhat.com>,
	Yuri Benditovich <yuri.benditovich@daynix.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Message-ID: <20230426104538-mutt-send-email-mst@kernel.org>
References: <20230423073532.105636-1-hengqi@linux.alibaba.com>
 <20230425165659-mutt-send-email-mst@kernel.org>
 <19e6d4e6-e3d8-7eca-4d54-d113b4cc5504@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <19e6d4e6-e3d8-7eca-4d54-d113b4cc5504@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [virtio-comment] [PATCH v13] virtio-net: support inner header
 hash

On Wed, Apr 26, 2023 at 10:14:30PM +0800, Heng Qi wrote:
> This does not mean that every device needs to implement and support all of
> these, they can choose to support some protocols they want.
> 
> I add these because we have scale application scenarios for modern protocols
> VXLAN-GPE/GENEVE:
> 
> +\item In scenarios where the same flow passing through different tunnels is expected to be received in the same queue,
> +      warm caches, lessing locking, etc. are optimized to obtain receiving performance.
> 
> 
> Maybe the legacy GRE, VXLAN-GPE and GENEVE? But it has a little crossover.
> 
> Thanks.

But VXLAN-GPE/GENEVE can use source port for entropy.

	It is recommended that the UDP source port number
	 be calculated using a hash of fields from the inner packet

That is best because
it allows end to end control and is protocol agnostic.
All that is missing is symmetric Toepliz and all is well?

-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

