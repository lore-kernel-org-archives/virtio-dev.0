Return-Path: <virtio-dev-return-11551-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66F85C64EC4
	for <virtio-dev@archiver.kernel.org>; Wed,  8 Mar 2023 21:09:32 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 8BA782AEF4
	for <virtio-dev@archiver.kernel.org>; Wed,  8 Mar 2023 21:09:31 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 614789866FB
	for <virtio-dev@archiver.kernel.org>; Wed,  8 Mar 2023 21:09:31 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 4702E986312; Wed,  8 Mar 2023 21:09:31 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 34209986416
	for <virtio-dev@lists.oasis-open.org>; Wed,  8 Mar 2023 21:09:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: BRGhiVEUMNSVbqF1ae-daA-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678309768;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/q+rEEgzuU5pDPu5CqtIZZ/ozkJ9g8b3JtE+xwdWI7g=;
        b=8IB3hC+uoVgJhNf55odN/xeu8JbdPue4qXH/VToCYK4+K68lhK59UBhJUIjkmYHDfJ
         hbTrI4k8MREVOfC9E4r4EVz3hdiNwmvBTJFt5uGELWGyT6e6Zazf7XVGLcuf00kGznbF
         oZUkM+OsQM+ZkO71DJhIXaNpciUMkica8b2XTDZvsmKQ3tOqN5hgNP0Hq+xLZRwqCDIE
         af9Gt3f7FS9XQogD/VAkHaMHie0Ciu1sv35XOGoaE7qEEMSNHlnWl3aWgWwbu93v0e9F
         zUddEh8B6Oh7QQnsuI3FzIc9oQKQsXzCTG9CGuZzWad51A0xsQAQlJaebfwti28DiM8G
         D+XQ==
X-Gm-Message-State: AO0yUKX45K9fF2H9uQYKpfsPhKF6zUxGbkgKFsVXQ20p2ZAf7AXb8IHb
	QfCErgOWbx6htPPdDI6C5/p63RMPnMKm11J2N+rfGetD09Vy27izQb11rmWd3U5zNzz8QwufZHc
	zbfu/W148EQmspi9fU+1p7zGADjDI
X-Received: by 2002:a05:6402:645:b0:4ac:bd71:c67e with SMTP id u5-20020a056402064500b004acbd71c67emr20123463edx.32.1678309768224;
        Wed, 08 Mar 2023 13:09:28 -0800 (PST)
X-Google-Smtp-Source: AK7set8rqxHS0IN1V5amGqQbnopv2zzf+ctG1uCeOCqdex5HG8BR7NqrWrQfAR0TYw73VWO8UAI10g==
X-Received: by 2002:a05:6402:645:b0:4ac:bd71:c67e with SMTP id u5-20020a056402064500b004acbd71c67emr20123450edx.32.1678309767955;
        Wed, 08 Mar 2023 13:09:27 -0800 (PST)
Date: Wed, 8 Mar 2023 16:09:22 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
	virtio-comment@lists.oasis-open.org,
	virtio-dev@lists.oasis-open.org, jasowang@redhat.com,
	cohuck@redhat.com, sgarzare@redhat.com, nrupal.jani@intel.com,
	Piotr.Uminski@intel.com, hang.yuan@intel.com,
	virtio@lists.oasis-open.org, Zhu Lingshan <lingshan.zhu@intel.com>,
	pasic@linux.ibm.com, Shahaf Shuler <shahafs@nvidia.com>,
	Parav Pandit <parav@nvidia.com>
Message-ID: <20230308160834-mutt-send-email-mst@kernel.org>
References: <cover.1677761896.git.mst@redhat.com>
 <20c81b66f0b21b5bd646c24840ac3f8462c86acf.1677761896.git.mst@redhat.com>
 <20230302204007.GD2554028@fedora>
 <20230302190230-mutt-send-email-mst@kernel.org>
 <027fff1b-8ed7-abc0-2331-b188b8822bf4@nvidia.com>
 <20230306174850-mutt-send-email-mst@kernel.org>
 <e12ab469-4586-f0f5-b084-8f2d7c031e11@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <e12ab469-4586-f0f5-b084-8f2d7c031e11@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [virtio-comment] Re: [PATCH v10 04/10] admin: introduce virtio
 admin virtqueues

On Wed, Mar 08, 2023 at 10:58:59PM +0200, Max Gurtovoy wrote:
> We have a non-spec prototypes for LM so please use our experience in this
> area.

Don't see what the fuss is about.  Nothing will prevent your device from
using a single queue if that is what you want.

-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

