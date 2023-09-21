Return-Path: <virtio-dev-return-13906-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0B2FCD494D
	for <virtio-dev@archiver.kernel.org>; Thu, 21 Sep 2023 05:13:14 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 1B3307A085
	for <virtio-dev@archiver.kernel.org>; Thu, 21 Sep 2023 05:13:14 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E962698668C
	for <virtio-dev@archiver.kernel.org>; Thu, 21 Sep 2023 05:13:13 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id C84C3983EB5; Thu, 21 Sep 2023 05:13:13 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B7AAA98667C
	for <virtio-dev@lists.oasis-open.org>; Thu, 21 Sep 2023 05:13:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: l7-H81ppPFC6jq-2unmNBw-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695273188; x=1695877988;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=De0gErulMFjjASvwtO5sMOu1Krx8CL3XlsUk4WCDmdk=;
        b=B0xMOd04WDxjgiQ6g4UOomGzP8VqTHvwFvatRwtoLpg8kc3zEnnH5WiKZ97fzQiJ62
         JY4pGb40AoEStOY+QkXnnvYTi7HAXK3LLnjX7ApS6zlZbxRCPyCucXcS+yWGq0F9TR/4
         P+QsF8uIR/Al7mJbAYikgqxiASvYBtMaaa3aohi5DsUzDMOS6eM3UARsGCV3iIu+zk9f
         0lkTeZzimZZjUslVF1Sot48VTf1qPQDHj28QHoKpDdeD0JYn4oqH5k/bfBh0P7InuPq/
         30yXq9IDJoeyD1+oJFtdCjsi5xrcXl6HN/rOw2DY7Wl3FM4A7ixpP14jXRS0WMNI8r8z
         7iZg==
X-Gm-Message-State: AOJu0YxeTnLZfqTOSNvX8UM11fQiBrZa+tWLOEqH3cJn1pjlrQCWb2qG
	LLQSru3ONNMwNnSfZK3YIoMV4wvASHWBhfGy8a5ewSLxuguLTR8j8nr/WJTdBKNYzVJElre5rDj
	FhaijgQPQynrFBgv8GTRFUG7ldyTY
X-Received: by 2002:a2e:8702:0:b0:2c0:318a:6ee5 with SMTP id m2-20020a2e8702000000b002c0318a6ee5mr3281863lji.5.1695273188801;
        Wed, 20 Sep 2023 22:13:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IERLGShkIjDllQQqUuc1VeUGNp0BrZVnx563uvVvNC6sn+d+sPMOXXYEMnlu/nT34iM9jcX/g==
X-Received: by 2002:a2e:8702:0:b0:2c0:318a:6ee5 with SMTP id m2-20020a2e8702000000b002c0318a6ee5mr3281850lji.5.1695273188437;
        Wed, 20 Sep 2023 22:13:08 -0700 (PDT)
Date: Thu, 21 Sep 2023 01:13:02 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Zhu, Lingshan" <lingshan.zhu@intel.com>
Cc: Parav Pandit <parav@nvidia.com>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	Jason Wang <jasowang@redhat.com>
Message-ID: <20230921011221-mutt-send-email-mst@kernel.org>
References: <20230918144312-mutt-send-email-mst@kernel.org>
 <bb402c34-ad07-063a-f4f5-d8c6b3a642c7@intel.com>
 <PH0PR12MB5481E94B590F6696F2A23028DCF9A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <c81dc719-1abf-ff56-1c1b-07536d197354@intel.com>
 <PH0PR12MB5481F731EF62DB5CCE777918DCF9A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <84b2f6b0-c4fb-9b28-53ab-cc8c0b6763c2@intel.com>
 <PH0PR12MB5481E1007F900AD9C2E52E1DDCF9A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <a009e6ec-4bea-d1c3-afbc-b65321341514@intel.com>
 <PH0PR12MB548188922E73315ABDAC16B5DCF9A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <7103fcd8-165b-f20a-3c38-b1d93e6a0dcd@intel.com>
MIME-Version: 1.0
In-Reply-To: <7103fcd8-165b-f20a-3c38-b1d93e6a0dcd@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: Re: [virtio-dev] Re: [PATCH 0/5] virtio: introduce SUSPEND bit and
 vq state

On Wed, Sep 20, 2023 at 07:27:05PM +0800, Zhu, Lingshan wrote:
> What if a malicious SW dump guest memory through admin vq LM facility?

What if malicious SW misconfigures vq through the SUSPEND bit facility?

-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

