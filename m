Return-Path: virtio-dev-return-7589-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 9573E986097
	for <virtio-dev@lists.oasis-open.org>; Fri, 17 Jul 2020 10:28:32 +0000 (UTC)
References: <20200518203721.7625-1-ndragazis@arrikto.com>
 <20200518203721.7625-2-ndragazis@arrikto.com> <87v9inv26c.fsf@linaro.org>
 <20200717092635.GB128195@stefanha-x1.localdomain>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20200717092635.GB128195@stefanha-x1.localdomain>
Date: Fri, 17 Jul 2020 11:28:28 +0100
Message-ID: <87mu3yv3jn.fsf@linaro.org>
MIME-Version: 1.0
Subject: Re: [virtio-dev] [PATCH v5 01/10] vhost-user: add vhost-user device
 type
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Nikos Dragazis <ndragazis@arrikto.com>, "Michael S . Tsirkin" <mst@redhat.com>, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>


Stefan Hajnoczi <stefanha@redhat.com> writes:

> On Thu, Jul 16, 2020 at 05:45:47PM +0100, Alex Benn=C3=A9e wrote:
>> Nikos Dragazis <ndragazis@arrikto.com> writes:
<snip>
>>=20
>> OK stuff is disappearing in later patches. Maybe it shouldn't be
>> introduced in the first place?
>
> I think Nikos sent the patches in this order to keep my authorship.
>
> Nikos: Feel free to squash everything into one patch and add your
> Signed-off-by. You can also set yourself as the author of the git
> commit. As long as my Signed-off-by stays on the patch it indicates I
> have given permission to use this text.

FWIW I think building up a document in discreet patches is still
worthwhile from an ease of review and following the "story" of a feature
development - just that if blocks of text are deleted later in that
story you might as well squash those deletions into the earlier patch.

--=20
Alex Benn=C3=A9e

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

