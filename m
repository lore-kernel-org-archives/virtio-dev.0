Return-Path: <virtio-dev-return-11914-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D9A5C761A6
	for <virtio-dev@archiver.kernel.org>; Mon,  3 Apr 2023 16:39:25 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 857FA23D67
	for <virtio-dev@archiver.kernel.org>; Mon,  3 Apr 2023 16:39:24 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 8122F98640A
	for <virtio-dev@archiver.kernel.org>; Mon,  3 Apr 2023 16:39:24 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 701409863E4; Mon,  3 Apr 2023 16:39:24 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5BF3C9863D6
	for <virtio-dev@lists.oasis-open.org>; Mon,  3 Apr 2023 16:39:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: DCrNTeyrOAm-EF_oUf8haQ-1
From: Cornelia Huck <cohuck@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>,
 virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org,
 jasowang@redhat.com, mst@redhat.com, sgarzare@redhat.com,
 stefanha@redhat.com, nrupal.jani@intel.com, Piotr.Uminski@intel.com,
 hang.yuan@intel.com
Cc: virtio@lists.oasis-open.org, Jiri Pirko <jiri@nvidia.com>, Zhu Lingshan
 <lingshan.zhu@intel.com>, pasic@linux.ibm.com, Shahaf Shuler
 <shahafs@nvidia.com>, Parav Pandit <parav@nvidia.com>, Max Gurtovoy
 <mgurtovoy@nvidia.com>
In-Reply-To: <cover.1680533760.git.mst@redhat.com>
Organization: Red Hat GmbH
References: <cover.1680533760.git.mst@redhat.com>
User-Agent: Notmuch/0.37 (https://notmuchmail.org)
Date: Mon, 03 Apr 2023 18:39:12 +0200
Message-ID: <87pm8kly33.fsf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Subject: [virtio-dev] Re: [PATCH v11 00/10] Introduce device group and device management

On Mon, Apr 03 2023, "Michael S. Tsirkin" <mst@redhat.com> wrote:

> Change log:
>
> since v10:
> 	addressed lots of comments by Jiri, Stefan. Cornelia, Lngshan, Parav, Max
> 	Cornelia, do you want to pick up 10/10 separately?

I'm not sure that makes sense -- if we refactor to introduce a patch
that deals with all of the currently unimplemented features (and respin
this series with the patch that lists the admin vq as unsupported on
top) we could do that, but I don't think it's worth the effort.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

