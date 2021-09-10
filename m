Return-Path: <virtio-dev-return-8658-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 608599864EE
	for <virtio-dev@lists.oasis-open.org>; Fri, 10 Sep 2021 09:45:17 +0000 (UTC)
References: <87v94ldrqq.fsf@linaro.org>
 <alpine.DEB.2.21.2108041055390.9768@sstabellini-ThinkPad-T480s>
 <YRuSPT9075NuWRYS@stefanha-x1.localdomain> <875yvkh1p1.fsf@linaro.org>
 <20210903080609.GD47953@laputa> <87czpqq9qu.fsf@linaro.org>
 <20210906022356.GD40187@laputa>
 <CACMJ4GaJyAnguzAEH87DSNN_+GhEa5jRbw11hVj-yWMAXx8V7w@mail.gmail.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri, 10 Sep 2021 10:35:52 +0100
In-reply-to: <CACMJ4GaJyAnguzAEH87DSNN_+GhEa5jRbw11hVj-yWMAXx8V7w@mail.gmail.com>
Message-ID: <87o890wyqe.fsf@linaro.org>
MIME-Version: 1.0
Subject: [virtio-dev] Re: [Stratos-dev] Enabling hypervisor agnosticism for VirtIO backends
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
To: Christopher Clark <christopher.w.clark@gmail.com>
Cc: AKASHI Takahiro <takahiro.akashi@linaro.org>, Wei Chen <Wei.Chen@arm.com>, Paul Durrant <paul@xen.org>, Stratos Mailing List <stratos-dev@op-lists.linaro.org>, virtio-dev@lists.oasis-open.org, Stefano Stabellini <sstabellini@kernel.org>, Jan Kiszka <jan.kiszka@siemens.com>, Arnd Bergmann <arnd.bergmann@linaro.org>, Juergen Gross <jgross@suse.com>, Julien Grall <julien@xen.org>, Carl van Schaik <cvanscha@qti.qualcomm.com>, Bertrand Marquis <Bertrand.Marquis@arm.com>, Stefan Hajnoczi <stefanha@redhat.com>, Artem Mygaiev <Artem_Mygaiev@epam.com>, Xen-devel <xen-devel@lists.xen.org>, Oleksandr Tyshchenko <olekstysh@gmail.com>, Oleksandr Tyshchenko <Oleksandr_Tyshchenko@epam.com>, Elena Afanasova <eafanasova@gmail.com>, James McKenzie <james@bromium.com>, Andrew Cooper <andrew.cooper3@citrix.com>, Rich Persaud <persaur@gmail.com>, Daniel Smith <dpsmith@apertussolutions.com>, Jason Andryuk <jandryuk@gmail.com>, eric chanudet <eric.chanudet@gmail.com>, Roger Pau =?utf-8?Q?Monn=C3=A9?= <roger.pau@citrix.com>
List-ID: <virtio-dev.lists.oasis-open.org>


Christopher Clark <christopher.w.clark@gmail.com> writes:

> On Sun, Sep 5, 2021 at 7:24 PM AKASHI Takahiro via Stratos-dev <stratos-d=
ev@op-lists.linaro.org> wrote:
>
>  Alex,
>
>  On Fri, Sep 03, 2021 at 10:28:06AM +0100, Alex Benn??e wrote:
<snip>
>
>  In configuration phase of virtio device, the latency won't be a big matt=
er.
>  In device operations (i.e. read/write to block devices), if we can
>  resolve 'mmap' issue, as Oleksandr is proposing right now, the only issu=
e is
>  how efficiently we can deliver notification to the opposite side. Right?
>  And this is a very common problem whatever approach we would take.
>
>  Anyhow, if we do care the latency in my approach, most of virtio-proxy-
>  related code can be re-implemented just as a stub (or shim?) library
>  since the protocols are defined as RPCs.
>  In this case, however, we would lose the benefit of providing "single bi=
nary"
>  BE.
>  (I know this is is an arguable requirement, though.)

The proposal for a single binary would always require something to shim
between hypervisors. This is still an area of discussion though. Having
a compile time selectable approach is practically unavoidable for "bare
metal" backends though because there are no other processes/layers that
communication with the hypervisor can be delegated to.

>
>  # Would we better discuss what "hypervisor-agnosticism" means?
>
> Is there a call that you could recommend that we join to discuss this and=
 the topics of this thread?
> There is definitely interest in pursuing a new interface for Argo that ca=
n be implemented in other hypervisors and enable guest binary
> portability between them, at least on the same hardware architecture,
> with VirtIO transport as a primary use case.

There is indeed ;-)

We have a regular open call every two week for the Stratos project which
you are welcome to attend. You can find the details on the project
overview page:

  https://linaro.atlassian.net/wiki/spaces/STR/overview

we regularly have teams from outside the project present their work as well=
.

> The notes from the Xen Summit Design Session on VirtIO Cross-Project BoF =
for Xen and Guest OS, which include context about the
> several separate approaches to VirtIO on Xen, have now been posted here:
> https://lists.xenproject.org/archives/html/xen-devel/2021-09/msg00472.htm=
l

Thanks for the link - looks like a very detailed summary.

>
> Christopher
>
> =20
>  -Takahiro Akashi


--=20
Alex Benn=C3=A9e

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

