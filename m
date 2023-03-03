Return-Path: <virtio-dev-return-11410-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E3C0C678D4
	for <virtio-dev@archiver.kernel.org>; Fri,  3 Mar 2023 00:02:06 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 9A3072A82E
	for <virtio-dev@archiver.kernel.org>; Fri,  3 Mar 2023 00:02:04 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 7030698678C
	for <virtio-dev@archiver.kernel.org>; Fri,  3 Mar 2023 00:02:04 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 596589866B0; Fri,  3 Mar 2023 00:02:04 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-Id: <virtio-dev.lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3F1529863C9
	for <virtio-dev@lists.oasis-open.org>; Fri,  3 Mar 2023 00:02:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: PaCBh7WCPJC9hyCOr-ukmg-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677801720;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1xjf6vnqVnmvcHc8NcDITmUQsigA17+Ejf30P8oXG7M=;
        b=QTtasaOOS6AAHqqQj4BBvbXdO0cLvIoIAGE69J0aZdo5YhbnaibLL8tfdcaIKwrDyy
         oql6xPhjtG5DxT85s9jVFFBsTCwZmiNO+O0N288jEMozjn8fFYOxd0rwlo1m/DBak2bc
         jDvineO3nuIm3DFSomtcTEVGOffzACieNu9PJWgwAQ8nCUi7oT4EjX02kNcYJ8YaWnri
         ylPgOGYnw0ti7ZbrvzNYr1IXhpsgmhuaAQzlfJ7WIPlANqKoQA8DDLkzU/wSICR7qdaz
         SDzVdh23AYwYWVX2ezB9OtB+1T0iQck5xqH+8sXKX4zjTS6TJImpIOW/2X/ZdhwPimGj
         P5aw==
X-Gm-Message-State: AO0yUKVyqFSkfSJ32OyNKs7O1C4eqsvMcJkjXurlJZAevN+SY2CiQ3BZ
	8TXq64G9ePv66f2fal9Ru6HCKMC5hiUnB7RArNS/E9pr8RwI/dndt02ce4d7xDgZ5LpBb1s4Yev
	PaKeEor2R5bO3oWUUDDnrW3pK6MX5
X-Received: by 2002:adf:d089:0:b0:2c7:17a4:4ece with SMTP id y9-20020adfd089000000b002c717a44ecemr63347wrh.26.1677801720066;
        Thu, 02 Mar 2023 16:02:00 -0800 (PST)
X-Google-Smtp-Source: AK7set/iiRr3SGtuip1+QWZ0fg2tqPj9wdZrAZef0nxLUMRxkfHb/8yAgKGj9e+ubnod3DmlqCeGqA==
X-Received: by 2002:adf:d089:0:b0:2c7:17a4:4ece with SMTP id y9-20020adfd089000000b002c717a44ecemr63328wrh.26.1677801719692;
        Thu, 02 Mar 2023 16:01:59 -0800 (PST)
Date: Thu, 2 Mar 2023 19:01:56 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Parav Pandit <parav@nvidia.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"jasowang@redhat.com" <jasowang@redhat.com>,
	"cohuck@redhat.com" <cohuck@redhat.com>,
	"sgarzare@redhat.com" <sgarzare@redhat.com>,
	"nrupal.jani@intel.com" <nrupal.jani@intel.com>,
	"Piotr.Uminski@intel.com" <Piotr.Uminski@intel.com>,
	"hang.yuan@intel.com" <hang.yuan@intel.com>,
	"virtio@lists.oasis-open.org" <virtio@lists.oasis-open.org>,
	Zhu Lingshan <lingshan.zhu@intel.com>,
	"pasic@linux.ibm.com" <pasic@linux.ibm.com>,
	Shahaf Shuler <shahafs@nvidia.com>,
	Max Gurtovoy <mgurtovoy@nvidia.com>
Message-ID: <20230302185803-mutt-send-email-mst@kernel.org>
References: <cover.1677761896.git.mst@redhat.com>
 <910b3607a5f255134d30b3e1233e564f564eafb8.1677761896.git.mst@redhat.com>
 <PH0PR12MB548116853CAC23DF9CA7345EDCB29@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230302201912.GC2554028@fedora>
MIME-Version: 1.0
In-Reply-To: <20230302201912.GC2554028@fedora>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [PATCH v10 03/10] admin: introduce group administration commands

On Thu, Mar 02, 2023 at 03:19:12PM -0500, Stefan Hajnoczi wrote:
> On Thu, Mar 02, 2023 at 06:40:29PM +0000, Parav Pandit wrote:
> > 
> > > From: Michael S. Tsirkin <mst@redhat.com>
> > > Sent: Thursday, March 2, 2023 8:05 AM
> > 
> > > +When \field{status} is VIRTIO_ADMIN_STATUS_OK, \field{status_qialifier}
> > > +is reserved and set to zero by the device.
> > > +
> > s/status_qialifier/status_qualifier
> > Missed from v10 of Feb.
> > 
> > > +When \field{status} is VIRTIO_ADMIN_STATUS_EINVAL, the following table
> > > +describes possible \field{status_qialifier} values:
> > s/status_qialifier/status_qualifier
> > 
> > Can you please add other useful error codes in addition to the EINVAL?
> > Few that we are needed EAGAIN, ENOMEM, EBUSY, ENODEV.
> 
> Please define a unique constant for each error condition that can occur
> instead of sharing catch-all errno constants between multiple error
> conditions. If a driver wants to squash them together into an errno,
> that's fine, but I think doing this at the hardware interface level is
> just propagating the mistakes of errnos.
> 
> Only status_qualifier is needed and the vague status field can be
> dropped. It's not clear to me why adding EAGAIN, ENOMEM, EBUSY, and
> ENODEV is useful. They have no meaning to the driver, only the
> status_qualifier really indicates what is going on.

At a high level at the moment we have only two cases:
- ok
- invalid input supplied by driver

maybe we will have more reasons for a failure - remains to
be seen.





> 
> I'm sure you guys have discussed this previously, but please provide
> rationale in the spec because it looks weird to someone with fresh eyes.
> 
> Stefan

Really most drivers just want to propagate errno to userspace.
All the detailed reporting is for sure well intentional but
in the end it is at best printed into log - end to end
people just end up with a switch statement
converting these to errno codes.
So we are passing them from device and this way there will be
some uniformity.


-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

