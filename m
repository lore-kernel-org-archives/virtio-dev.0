Return-Path: <virtio-dev-return-11575-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAAACC6FD1F
	for <virtio-dev@archiver.kernel.org>; Thu,  9 Mar 2023 14:22:51 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 2C65C26A34
	for <virtio-dev@archiver.kernel.org>; Thu,  9 Mar 2023 14:22:51 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 225FE986706
	for <virtio-dev@archiver.kernel.org>; Thu,  9 Mar 2023 14:22:51 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 0EFBB9866F6; Thu,  9 Mar 2023 14:22:51 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E90579866FE
	for <virtio-dev@lists.oasis-open.org>; Thu,  9 Mar 2023 14:22:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: uMvUNs8KNGCPyDFhWnDiIw-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678371762;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IormxYgOmYDO5wDnlJI+AddhMWqjg364qiQXEacrWK8=;
        b=FQ30Bm+t9lmWCnZ8TpUCdhmZyjyuhF/ChJ5usTNRSLJOjCk87y11Bb3/0A+5yA2G0d
         OBnaYiQOpSrb+ffyp2TeySXCKj0l4l/DOn4aM1wvP2gnJ4gFtfXUTC7iz0L906lOS74V
         xj+6EXWqGt4ovkrJhWE2nLJGn2sp54THrGc6yFjATa24AYZa2cZAbliMV1s2hyKZ3G3w
         //Z/W+/dXX9qs+P1qwgJC2+Pf8s1rPPWh4+OwMgxe4LSpbmRDX1j1LrmayAIShc2iT+P
         +qZ0lqnLXwBIvCSOFWjBA30MM5c3GBJXq1eS87z7xrgfV8vkBEwi8XbRaCAg5h7Kblnp
         weAw==
X-Gm-Message-State: AO0yUKUsv6LdNeD84qUoJS59JWzyiIijSP4JVl2Xu1lRM8CTzbUojFp+
	RrmYwJpiQYrzaBUqqtYKTZ5kmxB7uLkIncd2en/gHzXdnl3MOcUyNwVDt85NwUMxgQr08zACGfC
	fW4+gxDaiJyjheFyYF3Y5P7x4P8bb
X-Received: by 2002:a5d:6987:0:b0:2c7:1a97:ef8a with SMTP id g7-20020a5d6987000000b002c71a97ef8amr13681013wru.31.1678371761963;
        Thu, 09 Mar 2023 06:22:41 -0800 (PST)
X-Google-Smtp-Source: AK7set9IF+FkueGzQmW/+OptTO40nW9izYlyiCMQx5QPFHgeZdasjKCiNHRz8z2pbpaFvfKW0CQ0yw==
X-Received: by 2002:a5d:6987:0:b0:2c7:1a97:ef8a with SMTP id g7-20020a5d6987000000b002c71a97ef8amr13680832wru.31.1678371757615;
        Thu, 09 Mar 2023 06:22:37 -0800 (PST)
Date: Thu, 9 Mar 2023 09:22:32 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: David Edmondson <david.edmondson@oracle.com>,
	Jiri Pirko <jiri@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
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
	Shahaf Shuler <shahafs@nvidia.com>
Message-ID: <20230309091904-mutt-send-email-mst@kernel.org>
References: <ZAhdzCd6qwWydesz@nanopsycho>
 <20230308064505-mutt-send-email-mst@kernel.org>
 <ZAh61E/wQ/hSY/OI@nanopsycho>
 <18d51bc0-d759-1a05-cb7c-3d46c4ed2f1a@nvidia.com>
 <m2wn3rxgv5.fsf@oracle.com>
 <PH0PR12MB548150700B50006F9F174104DCB49@PH0PR12MB5481.namprd12.prod.outlook.com>
 <ZAmLIc97Ud09YfGT@nanopsycho>
 <PH0PR12MB54817E2CEFF003E793C9B2F3DCB59@PH0PR12MB5481.namprd12.prod.outlook.com>
 <m2mt4mxbt5.fsf@oracle.com>
 <PH0PR12MB5481FD2D2365CC08A5CD1E64DCB59@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB5481FD2D2365CC08A5CD1E64DCB59@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [virtio-comment] Re: [virtio] [PATCH v10 04/10] admin: introduce
 virtio admin virtqueues

On Thu, Mar 09, 2023 at 02:11:54PM +0000, Parav Pandit wrote:
> 
> 
> > From: David Edmondson <david.edmondson@oracle.com>
> > Sent: Thursday, March 9, 2023 9:03 AM
> > 
> > Parav Pandit <parav@nvidia.com> writes:
> > 
> > >> From: Jiri Pirko <jiri@nvidia.com>
> > >> Sent: Thursday, March 9, 2023 2:31 AM
> > >>
> > >> Wed, Mar 08, 2023 at 10:25:32PM CET, parav@nvidia.com wrote:
> > >> >
> > >> >> From: virtio-comment@lists.oasis-open.org
> > >> >> <virtio-comment@lists.oasis- open.org> On Behalf Of David
> > >> >> Edmondson
> > >> >
> > >> >> In support of live migration, might we end up moving large amounts
> > >> >> of device state through the admin queue?
> > >> >>
> > >> >Correct.
> > >> >
> > >> >> If so, that would seem to have some performance requirements,
> > >> >> though I don't know if it would justify multiple admin queues.
> > >> >DMA of the data through the proposed AQ is supported.
> > >> >
> > >> >If I understood Max correctly when Max said " This AQ is not aimed
> > >> >for performance ", he means that AQ doesn't have performance
> > >> >requirements as
> > >> io/network queues to complete millions of ops/sec.
> > >> >
> > >> >it is several hundred to maybe (on the higher side) thousand ops/sec
> > >> >during
> > >> LM, provisioning use case.
> > >>
> > >> But isn't it good to design it for performance from start? I mean,
> > >> state transfer of thousands of VFs at a time is definitelly performance
> > related, isn't it?
> > >>
> > > It is. Which part of the proposed AQ doesn't cover this aspect?
> > > The only issue that I see today is, that a given GET family of commands q
> > contains the read-only and write-only descriptors which require multiple dma
> > allocations on driver side.
> > 
> > I don't think that there is any assertion that the current proposal doesn't cover
> > this.
> > 
> > It was intended as an illustration to try and help determine whether multiple
> > AQs for a single device was a requirement given existing anticipated usage, or
> > a safeguard against potential future uses.
> 
> Got it.
> 
> So far my understanding is:
> 1. Single AQ is enough for currently cited use cases

FYI transport VQ work started off with multiple vqs.

> 2. Having the infrastructure to support multiple AQ is also good.
> The extra cost of this infra is only one read-only field = aq count as Michael proposed.
> 
> 3. Ability to send multiple outstanding commands and execute them out of order by device is/should be supported as long as IN_ORDER is not negotiated.
> Should it be relaxed for AQ that even if IN_ORDER is negotiated, AQ by default can be out of order queue?

I feel there's no need: driver can just avoid negotiating IN_ORDER.
Generally I'm not happy with IN_ORDER and have some ideas to
replace it with PARTIAL_ORDER, that will also address this.

> 4. Driver is the sole owner to decide if it is modifying an object through AQ, it should synchronize with ongoing AQ command on the same object or not.
> 5. If the command gets stuck for a very long time, the driver can recover the AQ using the existing Q RESET facility.
> 
> Do we agree with the above design thoughts?
> Or there is a better design than this discussed, and I missed it?
> 


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

