Return-Path: <virtio-dev-return-11530-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 387A1C6FD20
	for <virtio-dev@archiver.kernel.org>; Wed,  8 Mar 2023 14:31:44 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 97B092AD5F
	for <virtio-dev@archiver.kernel.org>; Wed,  8 Mar 2023 14:31:43 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 7229C9866F8
	for <virtio-dev@archiver.kernel.org>; Wed,  8 Mar 2023 14:31:43 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 546849866EE; Wed,  8 Mar 2023 14:31:43 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 40AE29866EF
	for <virtio-dev@lists.oasis-open.org>; Wed,  8 Mar 2023 14:31:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: f3P4ygDmP46MxJU2cZNCgw-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678285900;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Yq5cTmQIV4ktnZFtl96YB8FLcc/u0X3cdT8qXshCC1Q=;
        b=WmbL29c/3EJgTEfq3KVjisSs26pcmWfWd+hXxzeHRPioOYiG9PzDvT0bUiAuIxJ4F/
         qijxeVDDMZkmNOT3HKWGX70fZ4QKz9c8seF9V93CMaImOJyVVuowVG00qmdwjkikOH6P
         g5xGOtvLSFAKzhTf/8jf5TwMyDwfo+5jvtT1ATLPq7hKUHZWPiXUyhj+4J3fjqdWRSfT
         amyoxhCeMNMROOqOQF/zCRwmOYM2dzUbQI8J8Z0dvs7H/ofby81CHclKNXmX5kpzFcqc
         Yme3QyhbD3pkQUHZFhG60PTmJf/woeymzNiZy5GkxCITxmHYxkajPF4vAMa7zuiVvDyt
         lveA==
X-Gm-Message-State: AO0yUKWc4EJdVLk6UG/9OUShzLwkpU7LcakBVqNDzvooHjUqgzKZqOI5
	1W6/xorGTeEW6iVe/xj+lWV/zCfRIx20MJ/ojXpEU4i+PFZZ3Ahmn0Eada3wGNG2N4W5OsfohIJ
	X/8PpzdKV1yXfyM97TfgK0Lv4omdF
X-Received: by 2002:a17:907:6e1f:b0:8af:2a97:91d4 with SMTP id sd31-20020a1709076e1f00b008af2a9791d4mr21676325ejc.14.1678285900285;
        Wed, 08 Mar 2023 06:31:40 -0800 (PST)
X-Google-Smtp-Source: AK7set/76yHL52ITMsZnRmnJsDaIKrixFFYL9PCtlO28RLVlBpnseqABBnbZDySk37P1NtICQyyKBw==
X-Received: by 2002:a17:907:6e1f:b0:8af:2a97:91d4 with SMTP id sd31-20020a1709076e1f00b008af2a9791d4mr21676301ejc.14.1678285899998;
        Wed, 08 Mar 2023 06:31:39 -0800 (PST)
Date: Wed, 8 Mar 2023 09:31:36 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: virtio-dev@lists.oasis-open.org, virtio-comment@lists.oasis-open.org,
	Jason Wang <jasowang@redhat.com>, Parav Pandit <parav@nvidia.com>,
	Yuri Benditovich <yuri.benditovich@daynix.com>,
	Cornelia Huck <cohuck@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Message-ID: <20230308093057-mutt-send-email-mst@kernel.org>
References: <20230306154817.14115-1-hengqi@linux.alibaba.com>
 <615fdf98-c170-2855-7712-ec210ad649ad@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <615fdf98-c170-2855-7712-ec210ad649ad@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Subject: Re: [virtio-dev] [PATCH v10] virtio-net: support inner header hash

On Wed, Mar 08, 2023 at 10:27:13PM +0800, Heng Qi wrote:
> Do you have any comments, please?
> 
> Thanks. :)
> 
> 在 2023/3/6 下午11:48, Heng Qi 写道:

It's been just 2 partial days. Sit tight pls.

-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

