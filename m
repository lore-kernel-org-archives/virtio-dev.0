Return-Path: <virtio-comment-return-3430-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
References: <877d61wuc0.fsf@linaro.org> <87r10svr77.fsf@alyssa.is>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Mon, 05 Sep 2022 16:22:32 +0100
In-reply-to: <87r10svr77.fsf@alyssa.is>
Message-ID: <87v8q1keul.fsf@linaro.org>
MIME-Version: 1.0
Subject: [virtio-comment] Re: [virtio-dev] Next VirtIO device for Project Stratos?
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
To: Alyssa Ross <hi@alyssa.is>
Cc: stratos-dev@op-lists.linaro.org, virtio-dev@lists.oasis-open.org, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, Viresh Kumar <viresh.kumar@linaro.org>, Mathieu Poirier <mathieu.poirier@linaro.org>, Mike Holmes <mike.holmes@linaro.org>, Matt Spencer <Matt.Spencer@arm.com>, Peter Griffin <peter.griffin@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>, Arnd Bergmann <arnd.bergmann@linaro.org>, Peter Hilber <peter.hilber@opensynergy.com>, "Michael S. Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Puck Meerburg <puck@puckipedia.com>, Mikhail Golubev <Mikhail.Golubev@opensynergy.com>, Andriy Tryshnivskyy <andriy.tryshnivskyy@opensynergy.com>, Vasyl Vavrychuk <vasyl.vavrychuk@opensynergy.com>
List-ID: <virtio-dev.lists.oasis-open.org>


Alyssa Ross <hi@alyssa.is> writes:

> [[PGP Signed Part:Undecided]]
> Hi Alex and everyone else, just catching up on some mail and wanted to
> clarify some things:
>
> Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:
>
>> This email is driven by a brain storming session at a recent sprint
>> where we considered what VirtIO devices we should look at implementing
>> next. I ended up going through all the assigned device IDs hunting for
>> missing spec discussion and existing drivers so I'd welcome feedback
>> from anybody actively using them - especially as my suppositions about
>> device types I'm not familiar with may be way off!
>>
>> [...snip...]
>>
>> GPU device / 16
>> ---------------
>>
>> This is now a fairly mature part of the spec and has implementations is
>> the kernel, QEMU and a vhost-user backend. However as is commensurate
>> with the complexity of GPUs there is ongoing development moving from the
>> VirGL OpenGL encapsulation to a thing called GFXSTREAM which is meant to
>> make some things easier.
>>
>> A potential area of interest here is working out what the differences
>> are in use cases between virtio-gpu and virtio-wayland. virtio-wayland
>> is currently a ChromeOS only invention so hasn't seen any upstreaming or
>> specification work but may make more sense where multiple VMs are
>> drawing only elements of a final display which is composited by a master
>> program. For further reading see Alyssa's write-up:
>>
>>   https://alyssa.is/using-virtio-wl/
>>
>> I'm not sure how widely used the existing vhost-user backend is for
>> virtio-gpu but it could present an opportunity for a more beefy rust-vmm
>> backend implementation?
>
> As I understand it, virtio-wayland is effectively deprecated in favour
> of sending Wayland messages over cross-domain virtio-gpu contexts.  It's
> possible to do this now with an upstream kernel, whereas virtio-wayland
> always required a custom driver in the Chromium kernel.

That's good to know. I guess there is nothing that prevents the final
display of virtual GPUs from multiple guests being mapped onto the
final presentation? The automotive use case seems to treat each
individual VM with a UI as presenting a surface which the final console
manager composites up together depending on safety rules to display to
the user.

> But crosvm is still the only implementation of a virtio-gpu device that
> supports Wayland over cross-domain contexts, so it would be great to see
> a more generic implementation.  Especially because, while crosvm can
> share its virtio-gpu device over vhost-user, it does so in a way that's
> incompatible with the standardised vhost-user-gpu as implemented by
> QEMU.  When I asked the crosvm developers in their Matrix channel what
> it would take to use the standard vhost-user-gpu variant, they said that
> the standard variant was lacking functionality they needed, like mapping
> and unmapping GPU buffers into the guest.

Is this related to ensuring allocated buffers are properly aligned in
the host address space so the HW can use them without needing to copy
them again? I seem to recall this was one of the topics that came up in
one of the AGL VirtIO GPU workshops with the OpenSynergy people:

  https://confluence.automotivelinux.org/pages/viewpage.action?spaceKey=3DV=
E&title=3DMeeting+Agenda#MeetingAgenda-Jan20,2021

zero-copy is a goal everyone seems to want to make the mapping from
virtual to real hardware as efficient as possible. Of course zero-copy
is very much in opposition to more memory isolation between guests and
hosts (e.g. Xen/pKVM). Everyone it seems wants the moon on a stick.

> So if we wanted to push forward with getting making Wayland over
> virttio-gpu less crosvm specific, I suppose the first step would be to
> figure out with the crosvm developers what functionality is missing in
> the vhost-user-gpu protocol.  That would then make it possible to use
> crosvm's device (with the Wayland support) with other VMMs like QEMU.
>
> (CCing my colleage Puck, who has also been working with me on getting
> Wayland over virtio-gpu up and running outside of Chrome OS.)

Thanks. I'm very much an outside observer when it comes to GPUs so
welcome the expert input ;-)

>
> [[End of PGP Signed Part]]


--=20
Alex Benn=C3=A9e

This publicly archived list offers a means to provide input to the=0D
OASIS Virtual I/O Device (VIRTIO) TC.=0D
=0D
In order to verify user consent to the Feedback License terms and=0D
to minimize spam in the list archive, subscription is required=0D
before posting.=0D
=0D
Subscribe: virtio-comment-subscribe@lists.oasis-open.org=0D
Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org=0D
List help: virtio-comment-help@lists.oasis-open.org=0D
List archive: https://lists.oasis-open.org/archives/virtio-comment/=0D
Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.pdf=
=0D
List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lis=
ts=0D
Committee: https://www.oasis-open.org/committees/virtio/=0D
Join OASIS: https://www.oasis-open.org/join/

