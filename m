Return-Path: <virtio-dev-return-11353-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C45ADC6FA8E
	for <virtio-dev@archiver.kernel.org>; Thu,  2 Mar 2023 08:10:03 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id D8A7D1EDF3
	for <virtio-dev@archiver.kernel.org>; Thu,  2 Mar 2023 08:10:02 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id ACA4698667E
	for <virtio-dev@archiver.kernel.org>; Thu,  2 Mar 2023 08:10:02 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 82DA0983EB8; Thu,  2 Mar 2023 08:10:02 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-Id: <virtio-dev.lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 69D27986672
	for <virtio-dev@lists.oasis-open.org>; Thu,  2 Mar 2023 08:10:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: kBi-_cNuOLKUuF0icfsRfw-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677744598;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v5yJSF/AX8xysG6TQwpuHFMNVh2jMHddxss+J3vLx0M=;
        b=kdtggWbbDMIREDnbsFBAj1HcxKnEjoHajpDiODNQrbzJMyiCL3EKolqpGamBQJhzdV
         BxCt/TV74yb0u81fEIF18vNYR04VZGrusurJL0ixv3zcyRbZMKJss0dq2NY/HSElCGIr
         exgovSVWREo+WCxNXb/3fwcjlppaE6yzNWHfaLyjKEDzE+deiW+Gs8a79Hvxb6zQASM1
         fd4nqO8mkY+JdsQjmmDJ7Pdo/k0NWo5Dq1xppvbGxYWQ7Jm5vxkrhG5JAqqVYLYDiTvK
         YVsNcMdyUe3rSkRUyzQLWbBsyhfomoPg1vU1yGIn80GQA+gGUV60u1Bdyof5QPIi5dVS
         0rbg==
X-Gm-Message-State: AO0yUKWnbP4eHGu6kN5lru+4kyOjJvv4QB177BFqj98H2G49dylCSPBZ
	yzfy3T7NIV1Wp6tv9aR6MpI+IapMQVivnu3TfZryGQjDJgm/dtRBqp/tR7+5aTVpaLOc8GY3YtY
	+V+AcEgay6klW6TnNFPFgsAdQcePS
X-Received: by 2002:a05:600c:2ed3:b0:3ea:e4bb:33ef with SMTP id q19-20020a05600c2ed300b003eae4bb33efmr7506997wmn.9.1677744598802;
        Thu, 02 Mar 2023 00:09:58 -0800 (PST)
X-Google-Smtp-Source: AK7set+fMuLU+zpTiEqUbH1OBvd/cnBUs3A82j2yEx9rRmCF075yMG1tV71EnvmwyqyfSD9Up53Xsw==
X-Received: by 2002:a05:600c:2ed3:b0:3ea:e4bb:33ef with SMTP id q19-20020a05600c2ed300b003eae4bb33efmr7506976wmn.9.1677744598540;
        Thu, 02 Mar 2023 00:09:58 -0800 (PST)
Date: Thu, 2 Mar 2023 03:09:54 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Heng Qi <hengqi@linux.alibaba.com>, virtio-comment@lists.oasis-open.org,
	virtio-dev@lists.oasis-open.org, Parav Pandit <parav@nvidia.com>,
	Yuri Benditovich <yuri.benditovich@daynix.com>,
	Cornelia Huck <cohuck@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Message-ID: <20230302030935-mutt-send-email-mst@kernel.org>
References: <20230227023657-mutt-send-email-mst@kernel.org>
 <CACGkMEtOFC-xygzgECi82j4Q6PacpjVnyPMs1Q6c9PN0RfX5bw@mail.gmail.com>
 <20230227124800-mutt-send-email-mst@kernel.org>
 <CACGkMEvUaQuzMx4iwkaYg9t9Bz2Ev0eHAwgrWbNEwtQHZOkkvQ@mail.gmail.com>
 <20230228060352-mutt-send-email-mst@kernel.org>
 <CACGkMEvAGABhk6JX7+F-sDtRM7t1oONEz9wrgKM7iShmyYV34A@mail.gmail.com>
 <20230301053407-mutt-send-email-mst@kernel.org>
 <CACGkMEsSCGo01WsLvDojB5s8yjqL1mV0s328DnssosnNO=4M4w@mail.gmail.com>
 <20230302024129-mutt-send-email-mst@kernel.org>
 <CACGkMEtLRhJ=4xiwRO96hb6HOdO8n1on62Gyu72aV6+MWag2jQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEtLRhJ=4xiwRO96hb6HOdO8n1on62Gyu72aV6+MWag2jQ@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [PATCH v9] virtio-net: support inner header hash

On Thu, Mar 02, 2023 at 03:57:10PM +0800, Jason Wang wrote:
> Kernel had already used the eBPF program for hashing, classifying
> various types of eBPF program other than XDP/socket filter
> (pass/drop).
> 
> Thanks

where is it used for hashing?

-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

