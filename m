Return-Path: <virtio-dev-return-11640-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28F00C6FD1F
	for <virtio-dev@archiver.kernel.org>; Thu, 16 Mar 2023 07:36:39 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 579E760245
	for <virtio-dev@archiver.kernel.org>; Thu, 16 Mar 2023 07:36:38 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4FA89986434
	for <virtio-dev@archiver.kernel.org>; Thu, 16 Mar 2023 07:36:38 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 45A7A98641F; Thu, 16 Mar 2023 07:36:38 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 31B509863D7
	for <virtio-dev@lists.oasis-open.org>; Thu, 16 Mar 2023 07:36:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: KztznVurNraKEk1wMIgz9w-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678952191;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vI6jozccRNTHy1FCZotERV3/xeZyNfCIeHyd0iw4un8=;
        b=TTAFwD35z+X8pgtybWM0plLsXPEU+ZSf12GGC8XSPo8mH/Mi5kOftgMeH/yBc7htB6
         QdbaUFg3hQ0G1Rbr2c49deddhEoNXAYYp1QGiNnYXGV94D1lU7o4SXAoU5kw0xj163xu
         iBVdq+IGa7xixcc6o3dmUlNnLSstX4WpGStI5QHXte9iwYblDmhhAj1j5axYk0YOiKGq
         x3Aj3iuHARhQB4meSMRtyANRG/uvKoRFNDEgCQbuXTM8KsjSnKXdiitSyP/t0pGHvsqj
         X4SiwJx2HL1I78AxuiZOOOkqGTPh/cTNwavwN/cQAgznKdtp/FQCqSDXRm9H9WHZvJhu
         wMPA==
X-Gm-Message-State: AO0yUKXvEvynDDPF4mMs/NCn0vlzs73ES8LMMDEP2U37GD/UmCbHnrY9
	27QaMx7HZXg0UvQ2jtzGVFJJWMeFLr0adrKkMsl0riLJQd+8nTmzberJeAGFZJeRuLaDcO8QPE7
	lccrGQPdAmRBm/ALFKMcjK7SbXp4Q
X-Received: by 2002:a05:600c:4f0e:b0:3ed:3fe9:447a with SMTP id l14-20020a05600c4f0e00b003ed3fe9447amr2792336wmq.26.1678952191522;
        Thu, 16 Mar 2023 00:36:31 -0700 (PDT)
X-Google-Smtp-Source: AK7set81ys3aOTNWKxVW5F7wUtEjNRy+Vr3saf5i/rqregl24N9xnq9ReaNlc3L0hoZxv2rOxvXTtg==
X-Received: by 2002:a05:600c:4f0e:b0:3ed:3fe9:447a with SMTP id l14-20020a05600c4f0e00b003ed3fe9447amr2792318wmq.26.1678952191190;
        Thu, 16 Mar 2023 00:36:31 -0700 (PDT)
Date: Thu, 16 Mar 2023 03:36:28 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: Heng Qi <hengqi@linux.alibaba.com>, virtio-dev@lists.oasis-open.org,
	virtio-comment@lists.oasis-open.org,
	Jason Wang <jasowang@redhat.com>,
	Yuri Benditovich <yuri.benditovich@daynix.com>,
	Cornelia Huck <cohuck@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Message-ID: <20230316033526-mutt-send-email-mst@kernel.org>
References: <20230306154817.14115-1-hengqi@linux.alibaba.com>
 <c81de233-227c-73c8-a4bd-d43aa374dd86@nvidia.com>
 <20230315075954-mutt-send-email-mst@kernel.org>
 <11cce86e-8068-2e83-9fc5-e1b825adde29@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <11cce86e-8068-2e83-9fc5-e1b825adde29@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [virtio-comment] Re: [PATCH v10] virtio-net: support inner
 header hash

On Wed, Mar 15, 2023 at 07:24:57PM -0400, Parav Pandit wrote:
> > So what's left, GRE?  GRE is actually different, in that it's not IP at
> > all.
> Sorry, I wrongly wrote nvegre above.
> 
> IPoIP, GRE and NVGRE are left.
> 
> vxlan and geneve has the udp src entropy.
> 
> > 
> Not sure I understand "its not IP at all".
> 

GRE header is distinct from IP header and has its own flow ID.



-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

