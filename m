Return-Path: virtio-dev-return-6896-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id BE58A985FC3
	for <virtio-dev@lists.oasis-open.org>; Fri,  6 Mar 2020 20:34:16 +0000 (UTC)
References: <874kv15o4q.fsf@linaro.org>
 <20200306191427.GA132@matiasv.localdomain>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20200306191427.GA132@matiasv.localdomain>
Date: Fri, 06 Mar 2020 20:34:12 +0000
Message-ID: <87y2sd43zv.fsf@linaro.org>
MIME-Version: 1.0
Subject: Re: [virtio-dev] Backend libraries for VirtIO device emulation
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
To: Matias Ezequiel Vara Larsen <matiasevara@gmail.com>
Cc: virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>


Matias Ezequiel Vara Larsen <matiasevara@gmail.com> writes:

> Hello Alex,
> On Fri, Mar 06, 2020 at 06:33:57PM +0000, Alex Benn=C3=A9e wrote:
>> Hi,
>>=20
>> So the context of my question is what sort of common software layer is
>> required to implement a virtio backend entirely in userspace?
<snip>
>>=20
>> Thoughts?
>
> I am currently investigating the use of metamodeling to capture virtio
> concepts. The work is still a draft but you can give a look at
> https://github.com/MatiasVara/virtioml. One of the ideas is to base on a
> metamodel to generate the code for different targets, e.g., rust,
> c, etc. For the moment, I just played by generating the c header. This
> could be extended to other languages.

Thanks for the pointer, I shall have a look.

--=20
Alex Benn=C3=A9e

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

