Return-Path: <virtio-dev-return-12068-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B11D6C7619A
	for <virtio-dev@archiver.kernel.org>; Sat,  8 Apr 2023 10:29:23 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id DF309370EE
	for <virtio-dev@archiver.kernel.org>; Sat,  8 Apr 2023 10:29:22 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id CE4AC9865FA
	for <virtio-dev@archiver.kernel.org>; Sat,  8 Apr 2023 10:29:22 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id C4668986227; Sat,  8 Apr 2023 10:29:22 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B3CB09865E0
	for <virtio-dev@lists.oasis-open.org>; Sat,  8 Apr 2023 10:29:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: pp1m4pTMM-WFCmK6pD0buA-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680949757;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iZgnw5diLUhtU9d6+NnDvB/R1VS5VtHDi+ViZjQUOtg=;
        b=4E6qAarfrgbCM3XOajTTNecdpquNfqJ0C9Cvz3Hd498uT8HXW9wb0YKw8hfKmc5oVd
         7v1Py4AL9XggdB99ZHipmCgdgceYOr6abTzQ7q3c+zsOPrs+u1k4KVDhkZgfrJKyTOQV
         0yWod/1vMxHU9WAhX16Vblede3gHhu1Ln0l2Knl6QMxGFqWzOXer8NTiCJAv5AqMGFnP
         aSsRr3YXWBKkGcq9oz/FtNbpBwEieasGk0WonaDIiIWpX7qe/BRuC5lqFCEh7fdzGL8o
         yOR700FAT53nbu9SpPm+mSO6ukXsV/makdVttsqAmv9W9tO5BWF/4hBPNvE31e8cTawy
         0yYA==
X-Gm-Message-State: AAQBX9c0a/Z0utvyTyBIUtk3R+Hr1GbjaCppkrIKuPG1wWR2j+wSxWbV
	JVD5ZKxfHzrf2od/RQ/x3DCk+6Drmv2/hAiRDxt3GuL3qhnbtf56bqi6j++As2Z/Y+XzttMvq/M
	E+iC/BuApH81z5eSGfeJqZsGQqW6Y
X-Received: by 2002:a1c:ed18:0:b0:3f0:7e49:6a4d with SMTP id l24-20020a1ced18000000b003f07e496a4dmr993063wmh.11.1680949756888;
        Sat, 08 Apr 2023 03:29:16 -0700 (PDT)
X-Google-Smtp-Source: AKy350aIXbKmJ+ZJkcRAjSO/hz7qxfcGO4XJjcbJJ4eOge24/jLLsL3Wur777f1C53sWRSkgMo9Iew==
X-Received: by 2002:a1c:ed18:0:b0:3f0:7e49:6a4d with SMTP id l24-20020a1ced18000000b003f07e496a4dmr993049wmh.11.1680949756587;
        Sat, 08 Apr 2023 03:29:16 -0700 (PDT)
Date: Sat, 8 Apr 2023 06:29:12 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org,
	Parav Pandit <parav@nvidia.com>, Jason Wang <jasowang@redhat.com>,
	Yuri Benditovich <yuri.benditovich@daynix.com>,
	Cornelia Huck <cohuck@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Message-ID: <20230408062119-mutt-send-email-mst@kernel.org>
References: <20230228061309-mutt-send-email-mst@kernel.org>
 <25231225-59c8-91b0-e0dd-3dab8aa8164b@linux.alibaba.com>
 <20230308093311-mutt-send-email-mst@kernel.org>
 <c334a082-4b78-c7ea-e04a-6436f4965516@linux.alibaba.com>
 <20230309142612-mutt-send-email-mst@kernel.org>
 <021eeb40-aab1-07b9-cfe7-9dd61a32e0b3@linux.alibaba.com>
 <20230315074633-mutt-send-email-mst@kernel.org>
 <4b14043c-6059-1d26-060e-7dc653c4f401@linux.alibaba.com>
 <20230320154556-mutt-send-email-mst@kernel.org>
 <39f3ebf4-1141-8044-4ffc-e32e62edbb2c@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <39f3ebf4-1141-8044-4ffc-e32e62edbb2c@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Subject: [virtio-dev] Re: [virtio-comment] Re: [virtio-dev] Re: [virtio-comment] Re:
 [virtio-dev] Re: [PATCH v9] virtio-net: support inner header hash

On Thu, Mar 30, 2023 at 08:37:21PM +0800, Heng Qi wrote:
> 
> 
> 在 2023/3/21 上午3:48, Michael S. Tsirkin 写道:
> > On Wed, Mar 15, 2023 at 08:55:45PM +0800, Heng Qi wrote:
> > > We use the most basic GRE header fields (not NVGRE), not even optional
> > > fields.
> > I'd say yes, the most convincing usecase is with legacy GRE.
> 
> Yes. But we still have a strong need for VXLAN and GENEVE to do symmetric
> hashing. Please consider this.

Using a specific key seems fragile though in that a different one is
needed for e.g. ipv4 and ipv6.  An issue with VXLAN and GENEVE, yes?
Will support for XOR hashing address this sufficiently or is that not
acceptable to you? Or alternatively a modified Toeplitz, e.g. this
https://inbox.dpdk.org/dev/20190731123040.GG4512@6wind.com/
suggests Mellanox supports that. WDYT?

-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

