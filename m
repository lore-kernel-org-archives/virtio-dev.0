Return-Path: <virtio-dev-return-13808-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D26CC46CA1
	for <virtio-dev@archiver.kernel.org>; Mon, 18 Sep 2023 18:50:32 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id D2B8222371
	for <virtio-dev@archiver.kernel.org>; Mon, 18 Sep 2023 18:50:31 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A673498651F
	for <virtio-dev@archiver.kernel.org>; Mon, 18 Sep 2023 18:50:31 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 8149398640C; Mon, 18 Sep 2023 18:50:31 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id EF9AD98640D
	for <virtio-dev@lists.oasis-open.org>; Mon, 18 Sep 2023 18:49:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: mujHuFtQPG2p5D-8bdaonw-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695062945; x=1695667745;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G9RVu6MgyVdSHMiL2mwzVBIWqJhLkDoZXzBfL/dATGw=;
        b=j1djlAvAN3T5O4ShMS2xohyptcJ2qc60lt8t6uLB4C9fUeL9Boy4oRFY5b8qM4TS1k
         DKb8XG2NOgR5q6uwRsjW/VUDex0wvVOnMIhCOYHvfgNasCJ0EGgHEpA6WoWWGr9r+wUY
         tzN1jsMs7SDK5NybchlVKergmMeArkQ9vVDKGxPe+dlatuVMXQXdkTzr2gP6MCHjDfSr
         2tauOC3A+W148pMNWIfc6BmizFkHC77kUlZd2vQWSTw/g+mue9pHuxrxKtQCxz1sdBjm
         eNqiTS02yoF37C3ZBnOXBjhnhtM9XkbjXpp+H20Ac0gtoaSWu69Uw4ekmbG44hV4piEz
         MAOQ==
X-Gm-Message-State: AOJu0Yx9EsIY2ujwLk0Y7mjK6S+F3iD6wqZINV/lSGXZSa5DqGNnnD7X
	CfJG7bgSBYeArtH6n2yLajzcvVlJMD72J21gHkQjhbnVdlMHzrhDY9j5nFPJUzCHjvtjnk6VKwd
	x/OZ3W9r5X80CeZ8z1ZaS9E4yygt3
X-Received: by 2002:aa7:d954:0:b0:514:9ab4:3524 with SMTP id l20-20020aa7d954000000b005149ab43524mr7723409eds.7.1695062945225;
        Mon, 18 Sep 2023 11:49:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGIj9/evovBETO/2uyo9tLXJf2WoRJkno3zEpab71C0FZIcN438P0Cmp211bqaQ9yt5isbjZg==
X-Received: by 2002:aa7:d954:0:b0:514:9ab4:3524 with SMTP id l20-20020aa7d954000000b005149ab43524mr7723400eds.7.1695062944954;
        Mon, 18 Sep 2023 11:49:04 -0700 (PDT)
Date: Mon, 18 Sep 2023 14:49:01 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: "Zhu, Lingshan" <lingshan.zhu@intel.com>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	Jason Wang <jasowang@redhat.com>
Message-ID: <20230918144312-mutt-send-email-mst@kernel.org>
References: <PH0PR12MB548159C982509436C6499279DCF4A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <09045654-d69c-845d-ee26-636fa08f68b4@intel.com>
 <PH0PR12MB5481C41D4F32DA26D5831471DCFBA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <67680965-b115-32c7-dfdf-c56ab37bdd81@intel.com>
 <213a0f94-cee2-d8c5-3c5d-d2d7fc920e75@intel.com>
 <PH0PR12MB5481AE8C6E5EAFE9A4ADA6F6DCFBA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <f1fe513e-d42d-03a6-348c-5e58aac0a759@intel.com>
 <PH0PR12MB5481323A3B4D67EB66328476DCFBA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <5f01772f-eb27-bfe0-7f69-b83fbd90dda0@intel.com>
 <PH0PR12MB5481ABF4B9BC2082BC54AB1DDCFBA@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB5481ABF4B9BC2082BC54AB1DDCFBA@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: Re: [virtio-dev] Re: [PATCH 0/5] virtio: introduce SUSPEND bit and
 vq state

On Mon, Sep 18, 2023 at 06:41:55PM +0000, Parav Pandit wrote:
> > Please refer to the code for setting FEATURES_OK.
> It wont work when one needs to suspend the device.
> There is no point of doing such work over registers as fundamental framework is over the AQ.

Well not really. It's over admin commands. When these were built the
intent always was that it's possible to use admin commands through
another interface, other than admin queue. Is there a problem
implementing admin commands over a memory BAR? For example, I can see
an "admin command" capability pointing at a BAR where
commands are supplied, and using a new group type referring to
device itself.

-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

