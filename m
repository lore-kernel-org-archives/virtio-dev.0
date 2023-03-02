Return-Path: <virtio-dev-return-11405-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30DC8C6FA8E
	for <virtio-dev@archiver.kernel.org>; Thu,  2 Mar 2023 23:47:13 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 870512AEF5
	for <virtio-dev@archiver.kernel.org>; Thu,  2 Mar 2023 23:47:12 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 712BE9866D9
	for <virtio-dev@archiver.kernel.org>; Thu,  2 Mar 2023 23:47:12 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 606CF984091; Thu,  2 Mar 2023 23:47:12 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-Id: <virtio-dev.lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4D5CD9866AF
	for <virtio-dev@lists.oasis-open.org>; Thu,  2 Mar 2023 23:47:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: RnzfsQApNTKMyMeWFMN3ig-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677800829;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7kmNESDJd/uoRZCZWjxT+jXyYDNw0RtXWVnELQvpY9A=;
        b=QJs66StUXhswESz/nAi0GOdDYhFO1dqqktGz8XTYDDvf2uSGUmxxl1fD2nBAWjP2JT
         muLE9oIr9ZFU0RVRhIw+SbbOMp0rQEGx9aEY41Y55YIyIerhGJ3sUCqTJwqTMh8nWuJ+
         yVLmyxOzIFRutG83CSu6GgqsN2czUUKHhgm3xtqVR2QiQNZxhGJyWOfrvPapqqxBAxI7
         Q+3lFozB7Hm9vDXXZ2MVQgQfon7+1vOOOcmEiIer1GoyUZ6LqGDtW877YIsk/Vy5xoFt
         cjdcMRaoE6Ez7mP9nN/Af9iu9eR9zu5C4W+MJipO+6FSAqKTvzzzMcsXJr7is1qCcGxM
         tiSg==
X-Gm-Message-State: AO0yUKVlwmIA0tb5ZCQD3doQW9qnsoO0SrKnHI2nmX/Pr9Qb5cR/Y4Ey
	y+x43sxUV2Snd5Uzig59uv1Mg0hmWhOME2NON0/RSgL5Z+vZGGUiRC8rI9Xyrpzj50wbiwi7g/G
	Sgvn7cF7ZRUhJI+WdMEnkk0HlINer
X-Received: by 2002:a5d:678b:0:b0:2c5:5870:b589 with SMTP id v11-20020a5d678b000000b002c55870b589mr52625wru.14.1677800829324;
        Thu, 02 Mar 2023 15:47:09 -0800 (PST)
X-Google-Smtp-Source: AK7set8vPcck+Utwi0jzkxNp4VtCL/OQ0JYFZ8+TpxEkyYUcqx3rILJagQKxfBg0ONaFpr8SIizLoA==
X-Received: by 2002:a5d:678b:0:b0:2c5:5870:b589 with SMTP id v11-20020a5d678b000000b002c55870b589mr52615wru.14.1677800829029;
        Thu, 02 Mar 2023 15:47:09 -0800 (PST)
Date: Thu, 2 Mar 2023 18:47:05 -0500
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
Message-ID: <20230302184447-mutt-send-email-mst@kernel.org>
References: <cover.1677761896.git.mst@redhat.com>
 <910b3607a5f255134d30b3e1233e564f564eafb8.1677761896.git.mst@redhat.com>
 <PH0PR12MB548116853CAC23DF9CA7345EDCB29@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB548116853CAC23DF9CA7345EDCB29@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [PATCH v10 03/10] admin: introduce group administration commands

On Thu, Mar 02, 2023 at 06:40:29PM +0000, Parav Pandit wrote:
> 
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Thursday, March 2, 2023 8:05 AM
> 
> > +When \field{status} is VIRTIO_ADMIN_STATUS_OK, \field{status_qialifier}
> > +is reserved and set to zero by the device.
> > +
> s/status_qialifier/status_qualifier
> Missed from v10 of Feb.
> 
> > +When \field{status} is VIRTIO_ADMIN_STATUS_EINVAL, the following table
> > +describes possible \field{status_qialifier} values:
> s/status_qialifier/status_qualifier
> 
> Can you please add other useful error codes in addition to the EINVAL?
> Few that we are needed EAGAIN, ENOMEM, EBUSY, ENODEV.

We'll add them when there's a use-case.

> And with that, VIRTIO_ADMIN_STATUS_Q_INVALID_MEMBER moves under ENODEV error code.


No I think that belongs in in EINVAL - command is malformed.
ENODEV is more "The wrong type of device was given to a function that
expects a particular sort of device."


> > +\begin{tabular}{|l|l|l|}
> > +\hline
> > +Status & Name & Description \\
> > +\hline \hline
> > +0x00   & VIRTIO_ADMIN_STATUS_Q_INVALID_COMMAND   & command
> > error: no additional information  \\
> > +\hline
> > +0x01   & VIRTIO_ADMIN_STATUS_Q_INVALID_OPCODE    & unsupported or
> > invalid \field{opcode}  \\
> > +\hline
> > +0x02   & VIRTIO_ADMIN_STATUS_Q_INVALID_FIELD    & unsupported or
> > invalid field within \field{command_specific_data}  \\
> > +\hline
> > +0x03   & VIRTIO_ADMIN_STATUS_Q_INVALID_GROUP    & unsupported or
> > invalid \field{group_type} \\
> > +\hline
> > +0x04   & VIRTIO_ADMIN_STATUS_Q_INVALID_MEMBER    & unsupported or
> > invalid \field{group_member_id} \\
> > +\hline
> > +0x05-0xFFFF   & -    & reserved for future use \\
> > +\hline
> > +\end{tabular}


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

