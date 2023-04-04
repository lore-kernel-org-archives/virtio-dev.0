Return-Path: <virtio-dev-return-11963-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E11CC761A6
	for <virtio-dev@archiver.kernel.org>; Tue,  4 Apr 2023 08:28:55 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id AC6631FF82
	for <virtio-dev@archiver.kernel.org>; Tue,  4 Apr 2023 08:28:54 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 92CEA9863FE
	for <virtio-dev@archiver.kernel.org>; Tue,  4 Apr 2023 08:28:54 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 7D7779863E5; Tue,  4 Apr 2023 08:28:54 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 686F99863E6
	for <virtio-dev@lists.oasis-open.org>; Tue,  4 Apr 2023 08:28:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: BXaZQn8pP4iGlAT1Tsvj2A-1
From: Cornelia Huck <cohuck@redhat.com>
To: Parav Pandit <parav@nvidia.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: "virtio-comment@lists.oasis-open.org"
 <virtio-comment@lists.oasis-open.org>, Shahaf Shuler <shahafs@nvidia.com>,
 "mst@redhat.com" <mst@redhat.com>, "virtio-dev@lists.oasis-open.org"
 <virtio-dev@lists.oasis-open.org>, "pasic@linux.ibm.com"
 <pasic@linux.ibm.com>
In-Reply-To: <DM8PR12MB54802EF9E32D78394A233231DC929@DM8PR12MB5480.namprd12.prod.outlook.com>
Organization: Red Hat GmbH
References: <20230324013534.280820-1-parav@nvidia.com>
 <1679897351.7097778-1-xuanzhuo@linux.alibaba.com>
 <DM8PR12MB54802EF9E32D78394A233231DC929@DM8PR12MB5480.namprd12.prod.outlook.com>
User-Agent: Notmuch/0.37 (https://notmuchmail.org)
Date: Tue, 04 Apr 2023 10:28:48 +0200
Message-ID: <87bkk4jbjz.fsf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Subject: [virtio-dev] RE: [virtio-comment] [PATCH 0/3] transport-pci: msix summary update

On Mon, Apr 03 2023, Parav Pandit <parav@nvidia.com> wrote:

> Hi Cornelia,
>
>> From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
>> Sent: Monday, March 27, 2023 2:09 AM
>> Series:
>> 
>> Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
>> 
>
> It is editorial change rewording the text.
> Can you please take this short series forward?

Patch 1 (which Michael has already pushed) is editorial; for the other
two patches, I'm not that sure, especially as there still seems to be
some discussion?


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

