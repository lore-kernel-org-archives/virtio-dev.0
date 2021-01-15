Return-Path: virtio-dev-return-7920-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 96825986537
	for <virtio-dev@lists.oasis-open.org>; Fri, 15 Jan 2021 14:25:52 +0000 (UTC)
MIME-Version: 1.0
References: <20200623111325.237158-1-keiichiw@chromium.org> <87czy7l6uu.fsf@linaro.org>
In-Reply-To: <87czy7l6uu.fsf@linaro.org>
From: Keiichi Watanabe <keiichiw@chromium.org>
Date: Fri, 15 Jan 2021 23:25:35 +0900
Message-ID: <CAD90Vca=VPVM7+Cj-2cK3SWaSR_Ciajt7oOr0OyB-34bL15ewg@mail.gmail.com>
Subject: Re: [virtio-dev] [PATCH RFC v4 0/1] Virtio Video Device Specification
Content-Type: multipart/alternative; boundary="0000000000000435cd05b8f12678"
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, Matti.Moell@opensynergy.com
Cc: Linux Media Mailing List <linux-media@vger.kernel.org>, Alexandre Courbot <acourbot@chromium.org>, Alex Lau <alexlau@chromium.org>, Daniel Vetter <daniel@ffwll.ch>, Dylan Reid <dgreid@chromium.org>, David Staessens <dstaessens@chromium.org>, Dmitry Sepp <dmitry.sepp@opensynergy.com>, Enrico Granata <egranata@google.com>, Frediano Ziglio <fziglio@redhat.com>, Hans Verkuil <hverkuil@xs4all.nl>, Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?Q?St=C3=A9phane_Marchesin?= <marcheu@chromium.org>, Pawel Osciak <posciak@chromium.org>, spice-devel@lists.freedesktop.org, David Stevens <stevensd@chromium.org>, Tomasz Figa <tfiga@chromium.org>, uril@redhat.com, Samiullah Khawaja <samiullah.khawaja@opensynergy.com>, Kiran Pawar <kiran.pawar@opensynergy.com>, Saket Sinha <saket.sinha89@gmail.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Nicolas Dufresne <nicolas@ndufresne.ca>, "Michael S. Tsirkin" <mst@redhat.com>, virtio-dev@lists.oasis-open.org, Ruchika Gupta <ruchika.gupta@linaro.org>, Peter Griffin <peter.griffin@linaro.org>, Mike Holmes <mike.holmes@linaro.org>, dmitry.sepp@outlook.com
List-ID: <virtio-dev.lists.oasis-open.org>

--0000000000000435cd05b8f12678
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 15, 2021 at 3:18 AM Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:

>
> Keiichi Watanabe <keiichiw@chromium.org> writes:
>
> > This is the v4 RFC of virtio video device specification.
> > PDF versions are available at [1, 2].
> >
> > Note that this patch depends on a recent patchset "Cross-device resourc=
e
> > sharing" [3].
> >
> > Here is a list of major changes from v3:
> > * Redesingned struct definitions for each command and request based on
> >   discussions at [4].
> > * Renamed commands/structs/enums to more descriptive names.
> > * Had different structs and fields for image formats and bitstream
> formats.
> > * Added more detailed specification for supported video codecs.
> > * Made stream_id be allocated by the device.
> > * Had a single parameter struct per-stream instead of per-queue
> parameters and
> >   controls.
> > * Allowed the driver to specify the number of buffers to use via
> >   "cur_{image,bitstream}_buffers".
> > * Renamed RESOURCE_CREATE command to RESOURCE_ATTACH command and allow
> the
> >   driver to use this command when replacing backing memories as well.
> >
> > [5] is the diff of the header file from v3. Note that it only contains
> changes
> > in the header. We haven't updated the driver nor device implementation
> to focus
> > on protocol design discussion first.
> >
> > While it may appear that many parts have been changed since the previou=
s
> > revision, these changes are to address the issues raised in previous
> discussions
> > or/and to make the protocol simpler and easier to prevent misuse.
> > I'd appreciate any types of feedback.
> >
> > Best regards,
> > Keiichi
> >
> > [1] (full):
> https://drive.google.com/file/d/1DiOJZfUJ5wvFtnNFQicxt0zkp4Ob1o9C/view?us=
p=3Dsharing
> > [2] (only video section):
> https://drive.google.com/file/d/188uAkIWE0BsXETECez98y5fJKw8rslj3/view?us=
p=3Dsharing
> > [3]
> https://lists.oasis-open.org/archives/virtio-comment/202003/msg00035.html
> > [4] https://markmail.org/thread/c6h3e3zn647qli3w
> > [5]
> >
> https://chromium-review.googlesource.com/c/chromiumos/third_party/kernel/=
+/2164411
>
> Hi Keiichi,
>
> I wanted to ask what the current status of this spec was. Are you
> planning to submit a new revision of the specification due or are things
> fairly stable now?
>
> We are starting to think about next steps for virtualised video as part
> of Linaro's Stratos work. Specifically we are thinking about
> implementing backends and getting a stack up and running which we can
> use to experiment with multiple hypervisors and VM deployment
> approaches.
>
> Longer term goals included looking at how to integrate virtio-video with
> a secure world on ARM (e.g. feed video data to a secure world device for
> playback via virtio). As part of that we will also be looking at how to
> minimise the memory profile of the backend to do this.
>
> Looking at the virtio-spec repo it looks like the cross-device resource
> sharing is now merged:
>
>   87fa6b5 * virtio-gpu: add support for mapping/unmapping blob resources
>   89e7eb5 * virtio-gpu: add resource create blob
>   162578b * virtio-gpu: add the ability to export resources
>   68f66ff * content: define what an exported object is
>
> are there any other prerequisites?
>
> From a backend implementation point of view it makes sense to wait until
> there is a working frontend driver up-streamed into the kernel. I guess
> that is blocked on the final call for vote on the virtio spec?
>
> I'm sure there is scope for parallelism here but I wanted to get a sense
> of the current direction before embarking on work that would require a
> big re-write down the line.
>

Hi Alex,

Thanks for reaching out to me. I'm really happy to hear your team is
looking at virtio-video.

For the specification, we've been preparing the v5 spec by addressing
previous review comments and simplifying rules. I think we'll be able to
share it for reviewing soon. It won't require any additional mechanism
other than the resource sharing feature.

For the implementation, unfortunately, we haven't started implementing a
driver using the v5 protocol yet.
While we have the driver and device using the v3 protocol in Chrome OS
repository, some efforts are required to update them to support the v5
protocol because there are some gaps between the v3 protocol and the v4/v5
protocol.
I think the driver implementation is necessary for the spec to be merged,
but it's not yet clear when we can spend time implementing drivers. It's
likely to be after April or so.

IIRC, OpenSynergy folks, who implemented the v3 driver, also had some plan
to implement the driver with the v5 spec.
Matti, do you have any update on it? I'd really appreciate it if we could
keep working for upstream together.

Regards,
Keiichi




>
> Regards,
>
> --
> Alex Benn=C3=A9e
>

--0000000000000435cd05b8f12678
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Fri, Jan 15, 2021 at 3:18 AM Alex =
Benn=C3=A9e &lt;<a href=3D"mailto:alex.bennee@linaro.org">alex.bennee@linar=
o.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:=
1ex"><br>
Keiichi Watanabe &lt;<a href=3D"mailto:keiichiw@chromium.org" target=3D"_bl=
ank">keiichiw@chromium.org</a>&gt; writes:<br>
<br>
&gt; This is the v4 RFC of virtio video device specification.<br>
&gt; PDF versions are available at [1, 2].<br>
&gt;<br>
&gt; Note that this patch depends on a recent patchset &quot;Cross-device r=
esource<br>
&gt; sharing&quot; [3].<br>
&gt;<br>
&gt; Here is a list of major changes from v3:<br>
&gt; * Redesingned struct definitions for each command and request based on=
<br>
&gt;=C2=A0 =C2=A0discussions at [4].<br>
&gt; * Renamed commands/structs/enums to more descriptive names.<br>
&gt; * Had different structs and fields for image formats and bitstream for=
mats.<br>
&gt; * Added more detailed specification for supported video codecs.<br>
&gt; * Made stream_id be allocated by the device.<br>
&gt; * Had a single parameter struct per-stream instead of per-queue parame=
ters and<br>
&gt;=C2=A0 =C2=A0controls.<br>
&gt; * Allowed the driver to specify the number of buffers to use via<br>
&gt;=C2=A0 =C2=A0&quot;cur_{image,bitstream}_buffers&quot;.<br>
&gt; * Renamed RESOURCE_CREATE command to RESOURCE_ATTACH command and allow=
 the<br>
&gt;=C2=A0 =C2=A0driver to use this command when replacing backing memories=
 as well.<br>
&gt;<br>
&gt; [5] is the diff of the header file from v3. Note that it only contains=
 changes<br>
&gt; in the header. We haven&#39;t updated the driver nor device implementa=
tion to focus<br>
&gt; on protocol design discussion first.<br>
&gt;<br>
&gt; While it may appear that many parts have been changed since the previo=
us<br>
&gt; revision, these changes are to address the issues raised in previous d=
iscussions<br>
&gt; or/and to make the protocol simpler and easier to prevent misuse.<br>
&gt; I&#39;d appreciate any types of feedback.<br>
&gt;<br>
&gt; Best regards,<br>
&gt; Keiichi<br>
&gt;<br>
&gt; [1] (full): <a href=3D"https://drive.google.com/file/d/1DiOJZfUJ5wvFtn=
NFQicxt0zkp4Ob1o9C/view?usp=3Dsharing" rel=3D"noreferrer" target=3D"_blank"=
>https://drive.google.com/file/d/1DiOJZfUJ5wvFtnNFQicxt0zkp4Ob1o9C/view?usp=
=3Dsharing</a><br>
&gt; [2] (only video section): <a href=3D"https://drive.google.com/file/d/1=
88uAkIWE0BsXETECez98y5fJKw8rslj3/view?usp=3Dsharing" rel=3D"noreferrer" tar=
get=3D"_blank">https://drive.google.com/file/d/188uAkIWE0BsXETECez98y5fJKw8=
rslj3/view?usp=3Dsharing</a><br>
&gt; [3] <a href=3D"https://lists.oasis-open.org/archives/virtio-comment/20=
2003/msg00035.html" rel=3D"noreferrer" target=3D"_blank">https://lists.oasi=
s-open.org/archives/virtio-comment/202003/msg00035.html</a><br>
&gt; [4] <a href=3D"https://markmail.org/thread/c6h3e3zn647qli3w" rel=3D"no=
referrer" target=3D"_blank">https://markmail.org/thread/c6h3e3zn647qli3w</a=
><br>
&gt; [5]<br>
&gt; <a href=3D"https://chromium-review.googlesource.com/c/chromiumos/third=
_party/kernel/+/2164411" rel=3D"noreferrer" target=3D"_blank">https://chrom=
ium-review.googlesource.com/c/chromiumos/third_party/kernel/+/2164411</a><b=
r>
<br>
Hi Keiichi,<br>
<br>
I wanted to ask what the current status of this spec was. Are you<br>
planning to submit a new revision of the specification due or are things<br=
>
fairly stable now?<br>
<br>
We are starting to think about next steps for virtualised video as part<br>
of Linaro&#39;s Stratos work. Specifically we are thinking about<br>
implementing backends and getting a stack up and running which we can<br>
use to experiment with multiple hypervisors and VM deployment<br>
approaches.<br>
<br>
Longer term goals included looking at how to integrate virtio-video with<br=
>
a secure world on ARM (e.g. feed video data to a secure world device for<br=
>
playback via virtio). As part of that we will also be looking at how to<br>
minimise the memory profile of the backend to do this.<br>
<br>
Looking at the virtio-spec repo it looks like the cross-device resource<br>
sharing is now merged:<br>
<br>
=C2=A0 87fa6b5 * virtio-gpu: add support for mapping/unmapping blob resourc=
es<br>
=C2=A0 89e7eb5 * virtio-gpu: add resource create blob<br>
=C2=A0 162578b * virtio-gpu: add the ability to export resources<br>
=C2=A0 68f66ff * content: define what an exported object is<br>
<br>
are there any other prerequisites?<br>
<br>
From a backend implementation point of view it makes sense to wait until<br=
>
there is a working frontend driver up-streamed into the kernel. I guess<br>
that is blocked on the final call for vote on the virtio spec?<br>
<br>
I&#39;m sure there is scope for parallelism here but I wanted to get a sens=
e<br>
of the current direction before embarking on work that would require a<br>
big re-write down the line.<br></blockquote><div><br></div><div>Hi Alex,</d=
iv><div><br></div><div>Thanks for reaching out to me. I&#39;m really happy =
to hear your team is looking at virtio-video.</div><div><br></div><div>For =
the specification, we&#39;ve been preparing the v5 spec by addressing previ=
ous review comments and simplifying rules. I think we&#39;ll be able to sha=
re it for reviewing soon. It won&#39;t require any additional mechanism oth=
er than the resource sharing feature.</div><div><br></div><div>For the impl=
ementation, unfortunately, we haven&#39;t started implementing a driver usi=
ng the v5 protocol yet.</div><div>While we have the driver and device using=
 the v3 protocol in Chrome OS repository, some efforts are required to upda=
te them to support the v5 protocol because there are some gaps between the =
v3 protocol and the v4/v5 protocol.</div><div>I think the driver implementa=
tion is necessary for the spec to be merged, but it&#39;s not yet clear whe=
n we can spend time implementing drivers. It&#39;s likely to be after April=
 or so.<br></div><div><br></div><div>IIRC, OpenSynergy folks, who implement=
ed the v3 driver, also had some plan to implement the driver with the v5 sp=
ec.</div><div>Matti, do you have any update on it? I&#39;d really appreciat=
e it if we could keep working for upstream together.</div><div><br></div><d=
iv>Regards,</div><div>Keiichi</div><div><br></div><div><br></div><div>=C2=
=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
Regards,<br>
<br>
-- <br>
Alex Benn=C3=A9e<br>
</blockquote></div></div>

--0000000000000435cd05b8f12678--

