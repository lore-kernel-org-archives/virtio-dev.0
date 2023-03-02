Return-Path: <virtio-dev-return-11400-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93D92C6FA8E
	for <virtio-dev@archiver.kernel.org>; Thu,  2 Mar 2023 23:28:11 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id C59BB67048
	for <virtio-dev@archiver.kernel.org>; Thu,  2 Mar 2023 23:28:10 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id BEA5498678A
	for <virtio-dev@archiver.kernel.org>; Thu,  2 Mar 2023 23:28:10 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id B4B9E9866D5; Thu,  2 Mar 2023 23:28:10 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-Id: <virtio-dev.lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A33679866AF
	for <virtio-dev@lists.oasis-open.org>; Thu,  2 Mar 2023 23:28:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: EM0yh6dcNPiAu0pyaon2ZA-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677799682;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IRQ4fEhitoHJjbZ8BE3+sK+/gB0EjlBHhHp7NcRkUI0=;
        b=4kFnHiSkfnc2txHmKMzfTQbJpcvO+9prBh3kgEVet27xMD9U2wIlaegv49gvXm+qwm
         a2CYe6Q2cTMvsjTxXEsG0CYjl49ff8CxrPNn8EWdGgVJ+fLmolfdKuSxjE0yI4jNSlPj
         tL6JQ1cGsslWRzQVRHTTGEijKetP5MOUwK+2FjvnNcIDfleZdhvwLOavRNQvWYAmQDtr
         QUJAyma2rxDBS5Bwtz65S0ool3rt+xb57tBFwgx+gjeu/cBdM0fje8S482JLtrjwMuZp
         NMWVD9LvJgFgVOzbyu6BzF/ScxtZBOTxXWZzpdF6mbZH5loRyVItLk3A+op4jjKA7MFO
         VqIQ==
X-Gm-Message-State: AO0yUKUfBMOuM8gHiWWuohhUTIqJR3HiZrlBNjZpGgUaIZQUgMqVguAL
	lseyAirbj4+qfZO95SCJrnZonU64hs99a1esWDuXbXqMrr5kH+O9vhKUIsuVXP8qqkv20nKfMvG
	F8SAEO/r4JYtGwfuNXAokGWp0ccYT
X-Received: by 2002:a05:600c:1d16:b0:3df:9858:c030 with SMTP id l22-20020a05600c1d1600b003df9858c030mr2641505wms.5.1677799682695;
        Thu, 02 Mar 2023 15:28:02 -0800 (PST)
X-Google-Smtp-Source: AK7set966WY7edgENF7ivlg9mCkAl9b0mkWQ4FyPllbAM4cR0sgpIQG11hJh/LQoLyqSFQgxqk9nTA==
X-Received: by 2002:a05:600c:1d16:b0:3df:9858:c030 with SMTP id l22-20020a05600c1d1600b003df9858c030mr2641486wms.5.1677799682397;
        Thu, 02 Mar 2023 15:28:02 -0800 (PST)
Date: Thu, 2 Mar 2023 18:27:58 -0500
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
Message-ID: <20230302182744-mutt-send-email-mst@kernel.org>
References: <cover.1677761896.git.mst@redhat.com>
 <PH0PR12MB548198D02534039E29796988DCB29@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB548198D02534039E29796988DCB29@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [PATCH v10 00/10] Introduce device group and device management

On Thu, Mar 02, 2023 at 01:38:34PM +0000, Parav Pandit wrote:
> 
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Thursday, March 2, 2023 8:05 AM
> > Change log:
> > 
> > since v9:
> This version is supposed to be v11 from last v10 [1].
> https://lists.oasis-open.org/archives/virtio-dev/202302/msg00174.html

Good catch. Sorry.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

