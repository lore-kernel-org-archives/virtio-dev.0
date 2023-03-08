Return-Path: <virtio-dev-return-11539-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEB9CC64EC4
	for <virtio-dev@archiver.kernel.org>; Wed,  8 Mar 2023 16:31:04 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 566BA42A69
	for <virtio-dev@archiver.kernel.org>; Wed,  8 Mar 2023 16:31:04 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4ED109866FB
	for <virtio-dev@archiver.kernel.org>; Wed,  8 Mar 2023 16:31:04 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 4363C9866F0; Wed,  8 Mar 2023 16:31:04 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 2E54B9866F2
	for <virtio-dev@lists.oasis-open.org>; Wed,  8 Mar 2023 16:30:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: z-KH0qgaPOODRnpe6bb6zg-1
From: Cornelia Huck <cohuck@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Jiri Pirko <jiri@nvidia.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org,
 jasowang@redhat.com, sgarzare@redhat.com, stefanha@redhat.com,
 nrupal.jani@intel.com, Piotr.Uminski@intel.com, hang.yuan@intel.com,
 virtio@lists.oasis-open.org, Zhu Lingshan <lingshan.zhu@intel.com>,
 pasic@linux.ibm.com, Shahaf Shuler <shahafs@nvidia.com>, Parav Pandit
 <parav@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <20230306175020-mutt-send-email-mst@kernel.org>
Organization: Red Hat GmbH
References: <cover.1677761896.git.mst@redhat.com>
 <ZAXcqqdwfoLokT2l@nanopsycho>
 <20230306175020-mutt-send-email-mst@kernel.org>
User-Agent: Notmuch/0.37 (https://notmuchmail.org)
Date: Wed, 08 Mar 2023 17:30:48 +0100
Message-ID: <877cvrkxxj.fsf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Subject: [virtio-dev] Re: [virtio-comment] [PATCH v10 00/10] Introduce device group and
 device management

On Mon, Mar 06 2023, "Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Mon, Mar 06, 2023 at 01:29:30PM +0100, Jiri Pirko wrote:
>> Thu, Mar 02, 2023 at 02:04:48PM CET, mst@redhat.com wrote:
>> 
>> [...]
>> 
>> >
>> >TODO (maybe?) - probably ok to defer until this part is upstream:
>> >
>> >	Add "all members" member id.
>> >
>> >	Add commands for MSI, feature discovery.
>> >
>> >	Add commands for transport vq.
>> >
>> >
>> >My intent is to try and support both SR-IOV and SIOV
>> >usecases with the same structure and maybe even the same
>> >VQ.
>> 
>> Sorry to be late to the party, I'm trying to catch up. Is it common to
>> have cover letter for features this brief? I mean, from the cover
>> letter, I'm totally unable to understand what you are introducing here.
>> 
>> Could you elaborate about what you are aiming to achive with this?
>> Could you shed some usecases perhaps?
>> 
>> I have to be missing something obvious, but I don't get why any notion
>> of SR-IOV could be beneficial for virtio.
>> 
>
> Good point, I'll add a bit of motivation.
>
> For SR-IOV, it is not unusual for PFs to excercise control over VFs.
> There is interest in the community to include an interface to allow this
> in the virtio spec, when the PF is a virtio device.  This is what this
> patch does.

Unfortunately, information in the cover letter does not make it into
git -- should things like that go into the github issue (and into the
ballot?) It's useful both for reviewing (cover letter) and understanding
the rationale later (github/ballot).


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

