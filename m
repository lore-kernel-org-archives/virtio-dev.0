Return-Path: <virtio-dev-return-12262-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51E4AC77B72
	for <virtio-dev@archiver.kernel.org>; Mon, 17 Apr 2023 20:27:05 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id AB7E5C6259
	for <virtio-dev@archiver.kernel.org>; Mon, 17 Apr 2023 20:27:04 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A4358986408
	for <virtio-dev@archiver.kernel.org>; Mon, 17 Apr 2023 20:27:04 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 962C19863E3; Mon, 17 Apr 2023 20:27:04 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 79A399863E1
	for <virtio-dev@lists.oasis-open.org>; Mon, 17 Apr 2023 20:27:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: a6j55fBwNTKu6xNCLoA_Uw-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681763218; x=1684355218;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RSx/J/mUUeBzx5Nh7Un2GxCH2xQrTXANhPYTo7//qJA=;
        b=NW99lZaaFr3lHmF7GVDn872EHmSoXzedrBGAHMKHCp6bh45E5C7J0zjcOVXhsFIgsO
         1GEcrhh+odvWihUyD/XGsCvAJksFIwB7VKiWSIT5VhmW6yoSNreJ+VxE5OqOdlIkOd8f
         E/YG1uZDgUfLlXmA+NJq9QRA2W6uz63iaflvPr50EGMgUmHeXoi5N4dCYT6MUJhUu5Mi
         XGDT8FXnGkjH0dnat4/BjdZsUxbna27xCdlKFzZU8YHz8zJql1HwWvW77Iw5RxlCaWjb
         6gBq0wGgMWrk69KBXChn26TnK6lpvUUG1MW5GaGEsxpiSlQtnRIKebERIYvVhYObWP8H
         LKnQ==
X-Gm-Message-State: AAQBX9dnGoH2V7rg9CLtll2DHhJSWuHlL2ppsZkAWr/tl2BleFkwaPnK
	1MJymqf7aIWrJdZ8ONJYSjBcTe9hAS2/XFibzG9OcwOhiP+LE5c1uddZ4SkAYi+BQ0ypdQpGVU2
	c3nZ8A7XPLsIiTi1RBChxxZf3qe2i
X-Received: by 2002:aa7:ce06:0:b0:504:b325:bd4d with SMTP id d6-20020aa7ce06000000b00504b325bd4dmr168398edv.12.1681763218648;
        Mon, 17 Apr 2023 13:26:58 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZZRE7BGdxuXpIwatf+V2PsXXr5Jo+DdUGrZUIo1r0iZUbgOftriaj9SMSQN/W6e+lIV9VK1Q==
X-Received: by 2002:aa7:ce06:0:b0:504:b325:bd4d with SMTP id d6-20020aa7ce06000000b00504b325bd4dmr168384edv.12.1681763218332;
        Mon, 17 Apr 2023 13:26:58 -0700 (PDT)
Date: Mon, 17 Apr 2023 16:26:54 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: Jason Wang <jasowang@redhat.com>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"cohuck@redhat.com" <cohuck@redhat.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	Shahaf Shuler <shahafs@nvidia.com>,
	Satananda Burla <sburla@marvell.com>,
	Maxime Coquelin <maxime.coquelin@redhat.com>,
	Yan Vugenfirer <yan@daynix.com>
Message-ID: <20230417162618-mutt-send-email-mst@kernel.org>
References: <a74d3107-d38c-df15-e2ff-f848635f24bd@nvidia.com>
 <CACGkMEt+bGN7UYEopXPj0+deAnYm1VUNp05VvGHcJnkd8LzbGg@mail.gmail.com>
 <20230413130326-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54819A5D8FCEC6375D80897DDC989@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEvSSXyXQnRs=OiaSJnSEYHP83chL6-B5ZPCGx6TeW9W5Q@mail.gmail.com>
 <PH0PR12MB548135CF5268D979A6D8EDE8DC999@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEsHtC99kTTa0TrfeJuhV+F7e-WF7XRgbLJkCBQeAxW8pA@mail.gmail.com>
 <PH0PR12MB5481C29561D5E48BA5D8AEEEDC999@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEseO=4xDA+pH2x=CaJ6XyzHEx1ZFO-+uevJH50kLeSWhA@mail.gmail.com>
 <PH0PR12MB5481FFC95F54AD048927FF12DC9C9@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB5481FFC95F54AD048927FF12DC9C9@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [virtio-comment] Re: [PATCH 09/11] transport-pci: Describe PCI
 MMR dev config registers

On Mon, Apr 17, 2023 at 05:23:30PM +0000, Parav Pandit wrote:
> > Things might be simplified if we use separate queues for admin, transport and
> > legacy.
> > 
> Do you mean say we have three AQs, AQ_1, AQ_2, and AQ_3;
> AQ_1 of the PF used by admin work as SIOV device create, SRIOV MSIX configuration.
> AQ_2 of the PF used for transporting legacy config access of the PCI VF
> AQ_3 of the PF for some transport work.
> 
> If yes, sounds find to me.

Latest proposal simply leaves the split between AQs up to the driver.
Seems the most flexible.

-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

