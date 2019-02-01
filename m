Return-Path: virtio-dev-return-5361-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B1340985493
	for <virtio-dev@lists.oasis-open.org>; Fri,  1 Feb 2019 14:23:29 +0000 (UTC)
References: <0f4e7431-3c87-f783-579a-7e9fe6bc20d2@solarflare.com>
 <20181105085337.GA9934@stefanha-x1.localdomain>
 <6795ebb5-4f21-1274-fa35-b8354bc65049@solarflare.com>
 <20181112143728.GF21380@stefanha-x1.localdomain>
From: David Riddoch <driddoch@solarflare.com>
Message-ID: <f766b9dc-cf1b-41cb-643b-c61f6ae76a3b@solarflare.com>
Date: Fri, 1 Feb 2019 14:23:19 +0000
MIME-Version: 1.0
In-Reply-To: <20181112143728.GF21380@stefanha-x1.localdomain>
Content-Type: text/plain; charset="windows-1252"; format="flowed"
Content-Transfer-Encoding: quoted-printable
Content-Language: en-GB
Subject: Re: [virtio-dev] Device-to-driver notification management for
 hardware implementations
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Virtio-Dev <virtio-dev@lists.oasis-open.org>, Steve Pope <spope@solarflare.com>
List-ID: <virtio-dev.lists.oasis-open.org>


> Sounds fine to me.
>
> Could you send a VIRTIO spec patch so this can be discussed in detail?

Hi Stefan,

Since writing that proposal I've come to the conclusion that this=20
proposed extension would only really be useful if it were compulsory=20
rather than optional.=A0 It isn't essential for performance, and it=20
doesn't reduce complexity in the design if optional, as we still have to=20
operate without it.

I have however, found another problem that is much more important to=20
solve...see next email.

Best,
David

--=20
David Riddoch  <driddoch@solarflare.com> -- Chief Architect, Solarflare


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

