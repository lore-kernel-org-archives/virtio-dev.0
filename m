Return-Path: virtio-dev-return-6898-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 10CED98425C
	for <virtio-dev@lists.oasis-open.org>; Mon,  9 Mar 2020 08:11:28 +0000 (UTC)
References: <874kv15o4q.fsf@linaro.org> <20200306194058.GN3033@work-vm>
 <871rq55j12.fsf@linaro.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <6c34aa78-0152-371b-d664-038fcfda878a@siemens.com>
Date: Mon, 9 Mar 2020 09:11:24 +0100
MIME-Version: 1.0
In-Reply-To: <871rq55j12.fsf@linaro.org>
Content-Language: en-US
Subject: Re: [virtio-dev] Backend libraries for VirtIO device emulation
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On 06.03.20 21:24, Alex Benn=C3=A9e wrote:
> I suspect all of these multi-process models just hand wave away details
> like migration because that really does benefit from a single process
> with total awareness of the state of the system. That said I wonder how
> robust a guest can be if the device emulation may go away at any time?
>=20
> I guess in virtio if you never signal the consumption of a virt-queue it
> will still be there waiting until you restart the emulation process and
> pick up from where you left off?

The virtio spec seems be fine with individual backends dying. Recovery=20
depends on the hypervisor maintaining state for the backends - not sure=20
if that is easily doable, though.

But the challenge starts earlier: virtio-over-ivshmem is designed to=20
support independent backends lifecycles (and has no state except for=20
guest lifeness in the hypervisor). But while playing with that, I=20
immediately ran into Linux frontend code assuming that a virtio device=20
never dies (virtio console, IIRC). I suspect that there are more cases=20
in Linux, not to speak of other guests.

Jan

--=20
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

