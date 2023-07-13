Return-Path: <virtio-dev-return-13374-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5C56EB64DD
	for <virtio-dev@archiver.kernel.org>; Thu, 13 Jul 2023 09:32:43 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 271871318D3
	for <virtio-dev@archiver.kernel.org>; Thu, 13 Jul 2023 09:32:43 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 06F3C9867CE
	for <virtio-dev@archiver.kernel.org>; Thu, 13 Jul 2023 09:32:43 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id D5F1D9867C1; Thu, 13 Jul 2023 09:32:42 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C21F09867C3
	for <virtio-dev@lists.oasis-open.org>; Thu, 13 Jul 2023 09:32:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: DwDvyaXsM5K8U64yWuJ2ZA-1
From: Cornelia Huck <cohuck@redhat.com>
To: Parav Pandit <parav@nvidia.com>, virtio-comment@lists.oasis-open.org,
 mst@redhat.com
Cc: virtio-dev@lists.oasis-open.org, hengqi@linux.alibaba.com,
 shahafs@nvidia.com, Parav Pandit <parav@nvidia.com>
In-Reply-To: <87zg40qioi.fsf@redhat.com>
Organization: Red Hat GmbH
References: <20230712222405.455201-1-parav@nvidia.com>
 <87zg40qioi.fsf@redhat.com>
User-Agent: Notmuch/0.37 (https://notmuchmail.org)
Date: Thu, 13 Jul 2023 11:32:32 +0200
Message-ID: <87r0pcqhqn.fsf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Subject: [virtio-dev] Re: [virtio-comment] Re: [PATCH 0/4] Short document fixes to inner
 hash feature

On Thu, Jul 13 2023, Cornelia Huck <cohuck@redhat.com> wrote:

> On Thu, Jul 13 2023, Parav Pandit <parav@nvidia.com> wrote:
>
>> This short patches fixes the editing errors that stops the pdf and html
>> generation.
>>
>> These 3 fixes are for the patch [1] for the github issue [2].
>>
>> [1] https://lists.oasis-open.org/archives/virtio-comment/202307/msg00024.html
>> [2] https://github.com/oasis-tcs/virtio-spec/issues/173
>>
>> Patch summary:
>> patch-1 place C code under listing
>> patch-2 avoid hyphen and extra braces
>> patch-3 use table as hyperlink do not work well in C code listing
>> patch-4 refer 'advice' as 'note'
>>
>> Patch 1 to 3 appears to be must in the testing.
>> Patch 4 is not a fix and can be done later if it requires discussion.
>>
>> Parav Pandit (4):
>>   virtio-net: Place C code under listing
>>   virtio-net: Avoid hyphen and extra braces
>>   virtio-net: Use table to describe inner hash to rfc mapping
>>   virtio-net: Use note instead of advice
>>
>>  device-types/net/description.tex | 45 ++++++++++++++++++++++----------
>>  introduction.tex                 | 15 +++++------
>>  2 files changed, 38 insertions(+), 22 deletions(-)
>>
>
> FTR, this is the diff I have locally (I had missed one underscore in the
> references yesterday...); maybe we can make the intra-reference links in
> introdcution.tex a bit nicer, but otherwise, this should be the minimal
> change to make this build:

For the "make it look nicer" part, I think this one would get the job
done; opinions?

diff --git a/introduction.tex b/introduction.tex
index 6f10a94b6fde..1e39a4b2c529 100644
--- a/introduction.tex
+++ b/introduction.tex
@@ -106,8 +106,8 @@ \section{Normative References}\label{sec:Normative References}
     Generic Routing Encapsulation. This protocol is only specified for IPv4 and used as either the payload or delivery protocol.
 	\newline\url{https://datatracker.ietf.org/doc/rfc2784/}\\
 	\phantomsection\label{intro:rfc2890}\textbf{[RFC2890]} &
-    Key and Sequence Number Extensions to GRE \ref{intro:rfc2784}. This protocol describes extensions by which two fields, Key and
-    Sequence Number, can be optionally carried in the GRE Header \ref{intro:rfc2784}.
+    Key and Sequence Number Extensions to \hyperref[intro:rfc2784]{GRE}. This protocol describes extensions by which two fields, Key and
+    Sequence Number, can be optionally carried in the \hyperref[intro:rfc2784]{GRE} Header.
 	\newline\url{https://www.rfc-editor.org/rfc/rfc2890}\\
 	\phantomsection\label{intro:rfc7676}\textbf{[RFC7676]} &
     IPv6 Support for Generic Routing Encapsulation (GRE). This protocol is specified for IPv6 and used as either the payload or


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

