Return-Path: <virtio-dev-return-11406-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60992C678D4
	for <virtio-dev@archiver.kernel.org>; Thu,  2 Mar 2023 23:48:32 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 99CD742567
	for <virtio-dev@archiver.kernel.org>; Thu,  2 Mar 2023 23:48:31 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 821AB9866F9
	for <virtio-dev@archiver.kernel.org>; Thu,  2 Mar 2023 23:48:31 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 75EBA984091; Thu,  2 Mar 2023 23:48:31 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-Id: <virtio-dev.lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 664D89866AC
	for <virtio-dev@lists.oasis-open.org>; Thu,  2 Mar 2023 23:48:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: 7kiFZQuoOgywjs04ImFLxg-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677800906;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ONWgKkc4B01AmRRxZobGeewwCIOirXyWbK0b18A+MO0=;
        b=hSzUZnnqe+C+kn3U5QHYdaxAGp5E5RoDLlhAOxvibQUW86+mAwvVOKX7dBn4qp7dOZ
         QLScS34W/Ks8ivnH4g7uoJSYSPYJjCY6NlX6msHk2UkVrH8ZWbONewZyq1iIcK52j+l8
         YmSWIw79XgWwOoaa+ZJldDEkHu6v8HBLFCx2AXLCiHPPLhOBrEtNeXPCgGSkhbhK8P6J
         qRgLgqMm3D1zpzxcnhMIPtfJ8wluKYXYg4VDWkjk46BhK6juF/XO5DN0C4EWrSpmHj4j
         m3Zfk2m7JJgwb4PkVTjbqFlSFLUUr59FrVQNJPMO/if2hD4W5mbEWzKVJtBr3wm03Yk5
         KiAw==
X-Gm-Message-State: AO0yUKVvUeoEZxPEnk0U8neL4VU34D6LkcW+ExexLiwYJZqEqdgek3xP
	J3vKE+c4YjI8ASVF85Rq/I5K+vbJF7orRuAeb6uA/y2guKDrcXnnOEX/I7/sHEGqrqehYVhhBUO
	RvloDelbLXGIlyGvGNgKaTmPfsraf
X-Received: by 2002:a05:600c:1ca0:b0:3e9:f15b:935b with SMTP id k32-20020a05600c1ca000b003e9f15b935bmr9180560wms.32.1677800906730;
        Thu, 02 Mar 2023 15:48:26 -0800 (PST)
X-Google-Smtp-Source: AK7set+vpvI+kn5eiabcPm3f2d7QbExVXEtt93oyNtqHDhvz5xrEUX7IUf0AY8Fy6xTGMYIMY70Ufg==
X-Received: by 2002:a05:600c:1ca0:b0:3e9:f15b:935b with SMTP id k32-20020a05600c1ca000b003e9f15b935bmr9180547wms.32.1677800906411;
        Thu, 02 Mar 2023 15:48:26 -0800 (PST)
Date: Thu, 2 Mar 2023 18:48:22 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"jasowang@redhat.com" <jasowang@redhat.com>,
	"cohuck@redhat.com" <cohuck@redhat.com>,
	"sgarzare@redhat.com" <sgarzare@redhat.com>,
	"stefanha@redhat.com" <stefanha@redhat.com>,
	"nrupal.jani@intel.com" <nrupal.jani@intel.com>,
	"Piotr.Uminski@intel.com" <Piotr.Uminski@intel.com>,
	"hang.yuan@intel.com" <hang.yuan@intel.com>,
	"virtio@lists.oasis-open.org" <virtio@lists.oasis-open.org>,
	Zhu Lingshan <lingshan.zhu@intel.com>,
	"pasic@linux.ibm.com" <pasic@linux.ibm.com>,
	Shahaf Shuler <shahafs@nvidia.com>,
	Max Gurtovoy <mgurtovoy@nvidia.com>
Message-ID: <20230302184723-mutt-send-email-mst@kernel.org>
References: <cover.1677761896.git.mst@redhat.com>
 <20c81b66f0b21b5bd646c24840ac3f8462c86acf.1677761896.git.mst@redhat.com>
 <PH0PR12MB5481561C65A2FDD7D38C0AD9DCB29@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB5481561C65A2FDD7D38C0AD9DCB29@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [PATCH v10 04/10] admin: introduce virtio admin virtqueues

On Thu, Mar 02, 2023 at 06:40:42PM +0000, Parav Pandit wrote:
> 
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Thursday, March 2, 2023 8:05 AM
> 
> > +>>>>>>> 0edc690... admin: introduce virtio admin virtqueues
> 
> I requested to fix this in v10 of Feb, it was in some other patch.
> This hunk shifted here.

weird I remember fix it.

> > +  \item[VIRTIO_F_ADMIN_VQ(41)] This feature indicates that the device
> > + exposes one or more  administration virtqueues.
> > +
> Please remove extra white space between more and administration.

I will but it does not matter at all latex ignores it.

-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

