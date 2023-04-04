Return-Path: <virtio-dev-return-11961-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4E23C761AF
	for <virtio-dev@archiver.kernel.org>; Tue,  4 Apr 2023 08:10:31 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id F381D2A894
	for <virtio-dev@archiver.kernel.org>; Tue,  4 Apr 2023 08:10:30 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E929398640E
	for <virtio-dev@archiver.kernel.org>; Tue,  4 Apr 2023 08:10:30 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id DD89D9863E4; Tue,  4 Apr 2023 08:10:30 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id CE29E9863E5
	for <virtio-dev@lists.oasis-open.org>; Tue,  4 Apr 2023 08:10:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: VOBLJhnkNOqoO-LQXuSuoA-1
From: Cornelia Huck <cohuck@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org,
 jasowang@redhat.com, sgarzare@redhat.com, stefanha@redhat.com,
 nrupal.jani@intel.com, Piotr.Uminski@intel.com, hang.yuan@intel.com,
 virtio@lists.oasis-open.org, Jiri Pirko <jiri@nvidia.com>, Zhu Lingshan
 <lingshan.zhu@intel.com>, pasic@linux.ibm.com, Shahaf Shuler
 <shahafs@nvidia.com>, Parav Pandit <parav@nvidia.com>, Max Gurtovoy
 <mgurtovoy@nvidia.com>
In-Reply-To: <20230403133022-mutt-send-email-mst@kernel.org>
Organization: Red Hat GmbH
References: <cover.1680533760.git.mst@redhat.com>
 <87pm8kly33.fsf@redhat.com>
 <20230403133022-mutt-send-email-mst@kernel.org>
User-Agent: Notmuch/0.37 (https://notmuchmail.org)
Date: Tue, 04 Apr 2023 10:10:10 +0200
Message-ID: <87h6twjcf1.fsf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Subject: [virtio-dev] Re: [PATCH v11 00/10] Introduce device group and device management

On Mon, Apr 03 2023, "Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Mon, Apr 03, 2023 at 06:39:12PM +0200, Cornelia Huck wrote:
>> On Mon, Apr 03 2023, "Michael S. Tsirkin" <mst@redhat.com> wrote:
>> 
>> > Change log:
>> >
>> > since v10:
>> > 	addressed lots of comments by Jiri, Stefan. Cornelia, Lngshan, Parav, Max
>> > 	Cornelia, do you want to pick up 10/10 separately?
>> 
>> I'm not sure that makes sense -- if we refactor to introduce a patch
>> that deals with all of the currently unimplemented features (and respin
>> this series with the patch that lists the admin vq as unsupported on
>> top) we could do that, but I don't think it's worth the effort.
>
> My concern is that people are already kind of familiar with the
> patchset, reshuffling for no end result will cause everyone to re-read.

Yeah, let's just have 10/10 walk along with the rest.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

