Return-Path: <virtio-dev-return-13306-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5C48EB64D9
	for <virtio-dev@archiver.kernel.org>; Fri,  7 Jul 2023 08:32:17 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 4A01A370E8
	for <virtio-dev@archiver.kernel.org>; Fri,  7 Jul 2023 08:32:17 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 268E098680E
	for <virtio-dev@archiver.kernel.org>; Fri,  7 Jul 2023 08:32:17 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 130AE984091; Fri,  7 Jul 2023 08:32:17 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id F1E9C9867F9
	for <virtio-dev@lists.oasis-open.org>; Fri,  7 Jul 2023 08:32:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: IY7N5rUjPg-EBtG3_5Wvbw-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688718733; x=1691310733;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LgzJ5F+TP1sVDUpQSScY0cb9etuqeoi88b4RmgeP3yE=;
        b=ZH1EoWh1LDl3ReYF4z8oI6cJPm+P9Ua0fZU/DEnJmJzn71ZwFD+c8HN0/ovJSZzTS/
         jELEhNzip2zy/FH8EE8xNPP/xdyVvmow2r6ZTpVfhWS+fms0ENa5u99olsc00c92cbx5
         0piYpbQbM1hL9XWAMbCoCFGWt2sfrOlagl6rc2ihf7Z9smEkPdHo55c+0WcVulDE9Ewh
         yM5qDbOskupbdz0zV4DjmGkN7ut1RSTohrzJbiZB73VA+gES29Jz/b4p+3uEnN2T3SRm
         Qs9i6EVPoshLg7kaQUM3iZ9uR4ktO0zHjtGFwGyvodcAVDR6kiOC1YJCrSdNxc6URG7X
         PdQQ==
X-Gm-Message-State: ABy/qLbOrKn2lDau9VkPka4koLhKmXr0Veqtvu3kLIf0r4z1Lm253Ffw
	rGsWubWa0eUO9gO4s1dx6X7KEeTWJdmi+H769k0DJoYug9voJRzlzPkgzUZ50r3I7K/kQDzBEGj
	NWO8x6WvReGJUe/lFjSXvBOUVKGxz
X-Received: by 2002:adf:f9c9:0:b0:314:2132:a277 with SMTP id w9-20020adff9c9000000b003142132a277mr4804960wrr.9.1688718733638;
        Fri, 07 Jul 2023 01:32:13 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFQ5U5WjMowTW3wJixbVbrMzLjlkTllRywqmfmE/oraEXmtQtrYjwAPowgP81BKBIAQtXx6sw==
X-Received: by 2002:adf:f9c9:0:b0:314:2132:a277 with SMTP id w9-20020adff9c9000000b003142132a277mr4804943wrr.9.1688718733357;
        Fri, 07 Jul 2023 01:32:13 -0700 (PDT)
Date: Fri, 7 Jul 2023 04:32:08 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Parav Pandit <parav@nvidia.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	"david.edmondson@oracle.com" <david.edmondson@oracle.com>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"sburla@marvell.com" <sburla@marvell.com>,
	"jasowang@redhat.com" <jasowang@redhat.com>,
	Yishai Hadas <yishaih@nvidia.com>, Maor Gottlieb <maorg@nvidia.com>,
	Shahaf Shuler <shahafs@nvidia.com>
Message-ID: <20230707043025-mutt-send-email-mst@kernel.org>
References: <PH0PR12MB54817A61E0062B9BF3401836DC2CA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230706145538-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481074A79C630384382CB20DC2CA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230706154002-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481AF3000FFDBA2CBA5D7ADDC2CA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230706162505-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481B7E0DE415B1489818DE9DC2CA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230706164028-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54814132C3C74F00CD6F399BDC2CA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <87v8ew16oc.fsf@redhat.com>
MIME-Version: 1.0
In-Reply-To: <87v8ew16oc.fsf@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [virtio-comment] RE: [PATCH v10 4/4] transport-pci: Introduce
 group legacy group member config region access

On Fri, Jul 07, 2023 at 10:12:35AM +0200, Cornelia Huck wrote:
> [Also, I notice that the discussion seems to get bogged down in tiny
> details, fundamental statements, or a mixture of both. It might
> sometimes be helpful to just step back, re-read the original proposal,
> and only then answer. Otherwise, this leads to frustration for everyone
> involved.]

I feel in this instance we are actually good. All that's left is
small details that's why we are discussing them.

-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

