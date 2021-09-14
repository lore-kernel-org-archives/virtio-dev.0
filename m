Return-Path: <virtio-dev-return-8663-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 86ED7986314
	for <virtio-dev@lists.oasis-open.org>; Tue, 14 Sep 2021 14:34:10 +0000 (UTC)
References: <87v94ldrqq.fsf@linaro.org>
 <alpine.DEB.2.21.2108041055390.9768@sstabellini-ThinkPad-T480s>
 <YRuSPT9075NuWRYS@stefanha-x1.localdomain> <875yvkh1p1.fsf@linaro.org>
 <20210903080609.GD47953@laputa> <87czpqq9qu.fsf@linaro.org>
 <20210906022356.GD40187@laputa>
 <alpine.DEB.2.21.2109131615570.10523@sstabellini-ThinkPad-T480s>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue, 14 Sep 2021 15:25:22 +0100
In-reply-to: <alpine.DEB.2.21.2109131615570.10523@sstabellini-ThinkPad-T480s>
Message-ID: <878rzzusyp.fsf@linaro.org>
MIME-Version: 1.0
Subject: [virtio-dev] Re: Enabling hypervisor agnosticism for VirtIO backends
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
To: Stefano Stabellini <stefano.stabellini@xilinx.com>
Cc: AKASHI Takahiro <takahiro.akashi@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>, Stratos Mailing List <stratos-dev@op-lists.linaro.org>, virtio-dev@lists.oasis-open.org, Arnd Bergmann <arnd.bergmann@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, Jan Kiszka <jan.kiszka@siemens.com>, Carl van Schaik <cvanscha@qti.qualcomm.com>, pratikp@quicinc.com, Srivatsa Vaddagiri <vatsa@codeaurora.org>, Jean-Philippe Brucker <jean-philippe@linaro.org>, Mathieu Poirier <mathieu.poirier@linaro.org>, Wei.Chen@arm.com, olekstysh@gmail.com, Oleksandr_Tyshchenko@epam.com, Bertrand.Marquis@arm.com, Artem_Mygaiev@epam.com, julien@xen.org, jgross@suse.com, paul@xen.org, xen-devel@lists.xen.org, Elena Afanasova <eafanasova@gmail.com>
List-ID: <virtio-dev.lists.oasis-open.org>


Stefano Stabellini <stefano.stabellini@xilinx.com> writes:

> On Mon, 6 Sep 2021, AKASHI Takahiro wrote:
>> > the second is how many context switches are involved in a transaction.
>> > Of course with all things there is a trade off. Things involving the
>> > very tightest latency would probably opt for a bare metal backend whic=
h
>> > I think would imply hypervisor knowledge in the backend binary.
>>=20
>> In configuration phase of virtio device, the latency won't be a big matt=
er.
>> In device operations (i.e. read/write to block devices), if we can
>> resolve 'mmap' issue, as Oleksandr is proposing right now, the only issu=
e is
>> how efficiently we can deliver notification to the opposite side. Right?
>> And this is a very common problem whatever approach we would take.
>>=20
>> Anyhow, if we do care the latency in my approach, most of virtio-proxy-
>> related code can be re-implemented just as a stub (or shim?) library
>> since the protocols are defined as RPCs.
>> In this case, however, we would lose the benefit of providing "single bi=
nary"
>> BE.
>> (I know this is is an arguable requirement, though.)
>
> In my experience, latency, performance, and security are far more
> important than providing a single binary.
>
> In my opinion, we should optimize for the best performance and security,
> then be practical on the topic of hypervisor agnosticism. For instance,
> a shared source with a small hypervisor-specific component, with one
> implementation of the small component for each hypervisor, would provide
> a good enough hypervisor abstraction. It is good to be hypervisor
> agnostic, but I wouldn't go extra lengths to have a single binary.

I agree it shouldn't be a primary goal although a single binary working
with helpers to bridge the gap would make a cool demo. The real aim of
agnosticism is avoid having multiple implementations of the backend
itself for no other reason than a change in hypervisor.

> I cannot picture a case where a BE binary needs to be moved between
> different hypervisors and a recompilation is impossible (BE, not FE).
> Instead, I can definitely imagine detailed requirements on IRQ latency
> having to be lower than 10us or bandwidth higher than 500 MB/sec.
>
> Instead of virtio-proxy, my suggestion is to work together on a common
> project and common source with others interested in the same problem.
>
> I would pick something like kvmtool as a basis. It doesn't have to be
> kvmtools, and kvmtools specifically is GPL-licensed, which is
> unfortunate because it would help if the license was BSD-style for ease
> of integration with Zephyr and other RTOSes.

This does imply making some choices, especially the implementation
language. However I feel that C is really the lowest common denominator
here and I get the sense that people would rather avoid it if they could
given the potential security implications of a bug prone back end. This
is what is prompting interest in Rust.

> As long as the project is open to working together on multiple
> hypervisors and deployment models then it is fine. For instance, the
> shared source could be based on OpenAMP kvmtool [1] (the original
> kvmtool likely prefers to stay small and narrow-focused on KVM). OpenAMP
> kvmtool was created to add support for hypervisor-less virtio but they
> are very open to hypervisors too. It could be a good place to add a Xen
> implementation, a KVM fatqueue implementation, a Jailhouse
> implementation, etc. -- work together toward the common goal of a single
> BE source (not binary) supporting multiple different deployment models.
>
>
> [1] https://github.com/OpenAMP/kvmtool


--=20
Alex Benn=C3=A9e

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

