Return-Path: virtio-dev-return-8188-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id BA32E98663F
	for <virtio-dev@lists.oasis-open.org>; Thu, 10 Jun 2021 23:15:44 +0000 (UTC)
MIME-Version: 1.0
References: <CABATKF9Vjf1NE0EjToKfp=1aPcGieeny1k8rkfVv6BFZ=+b4sw@mail.gmail.com>
 <YJ07vrCt3thO5MM/@stefanha-x1.localdomain> <CABATKF_vRfnkybEyj-PejKYPud0=FNPscRJ9=ztKzWiySnyHVQ@mail.gmail.com>
 <adc1355d-7ecb-7617-536e-1082ecbba039@metux.net> <CABATKF-cFHeiLz1ruwKaYHHHo3xuoKcCods+WAzhXojo6wEO1w@mail.gmail.com>
 <40119ebe-04c5-ce46-e015-6e69086f2186@metux.net> <CABATKF-t-xfj0cTa6zsnKJwLbXUCLaSZOqUWXDEOfKpR3KCPgw@mail.gmail.com>
 <ea3a5d06-d18b-ba44-f6e9-224eaebfdf95@metux.net> <CABATKF-G5NOAhh4EQqjOSRCS=PjjNpN+dKa7ezXTJaUyoJwNcg@mail.gmail.com>
 <70ada7a8-7a9c-6d5f-a881-e436bd30cb9b@metux.net>
In-Reply-To: <70ada7a8-7a9c-6d5f-a881-e436bd30cb9b@metux.net>
From: Hao Chen <chenhaosjtuacm@google.com>
Date: Thu, 10 Jun 2021 16:15:31 -0700
Message-ID: <CABATKF-Oa52Hq9U+-4zOY7+aL-mrf6+DmhSG51WRnLPjFsdXUA@mail.gmail.com>
Subject: Re: [virtio-dev] [PATCH] Add virtio parameter server device specification
Content-Type: multipart/alternative; boundary="000000000000feae4c05c47191df"
To: "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

--000000000000feae4c05c47191df
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Stefan and Enrico,

> What does "share the same configuration" mean? ...

It means these values share the virtio_parameter_server_prop_config.
So they will have the same mode (e.g., all of them are read-only and
static).
Also they have the same encoding rule, for example, each value contains one
64-bit integer and three 64-bit floating point numbers.

> What are the units of this timestamp (nanoseconds, milliseconds,
> seconds)?

I don't know if I should define the unit, in our current usecase,
it can be unix timestamp in milliseconds, but I don't know if it is
true for all potential usecases. Maybe in some cases there will not
be real-world timestamp but using sequential numbers instead. So I
leave it blank here. The reason of having this field is the guest VM
userspace may need to know the order of the generation of the data.
In some cases the guest userspace may also care about the real generation
time. Do you prefer having a clearer definition here?

> A common request layout for devices is:
>
>  struct request {
>      struct request_header header;
>      u8 data[];
>      struct request_footer footer;
>  };

I didn't see any "footers" in the current spec. Could you please explain
more?

> Can you rephrase the definition of MUTABLE? I don't understand what it
> means, especially since there is already a WRITE permission that
> indicates read-only parameters. Why is MUTABLE needed?

Write permission and mutable variables are different things. For example,
if we use a flag to indicate if it is sunny outside, we cannot write to it
since we cannot control the weather, but the value is definitely mutable
because weather may change.

> Does CONTINUOUS mean that the device expects to update the value?
> ...  then PERIODIC might be a clearer name than CONTINUOUS

Both MUTABLE and CONTINUOUS variables may be changed by the device,
but MUTABLE value changes usually represent async value updates (like
IP address changed, gear switched, or weather changed, etc.), the value
need to be send to the driver in every updates; while CONTINOUS values
are more like rated sensor data.

> > +The properties with the same \field{prop_id} share the configuration.

> It is not clear to mean what a "configuration" is.

"configuration" means "virtio_parameter_server_prop_config"


> > \field{min_sample_freq} and
> > +\field{max_sample_freq} are the sampling rate range for the
> > +\field{VIRTIO_PARAMETER_SERVER_M_CONTINUOUS} values.

> Is this really needed since the device interface also supports pub/sub?

It is, those numbers indicate how fast the device will sample the data for
the driver. The driver doesn't fetch the value at the max rate, it just
check.

> > \field{desc} is
> > the optional string
> > +description.

> Is this the parameter's name ("temperature_sensor_4") or is it a
> description ("Main board temperature sensor")?

What is the difference? The device use the prop_id to identify parameters
and this is for human anyways.

> > \field{params} are for the customized configuration parameters.

> This looks like a vendor-specific extension mechanism. It's opaque so
> there's no way for the driver to skip over parameters it doesn't
> understand. That could be a problem for version compatibility if the
> device/driver are updated and expect different param[] data formats.
> Perhaps it would help to define the structure that allows the driver to
> skip unknown parameters?

The driver does not care. The driver's behavior is nothing to do with the
configs. The configs are for the userspace to understand the value it
receives. In each specific case, there will be some special "configs" that
the userspace app may need to know, but the driver is still act as a genera=
l
parameter server driver.

> On 9P it would just be issuing one Tread per file you're intersted in
> (of course, after Rread comes in, you'll have to send it again, if you
> wanna continue to read).

> How is that so different from subscriptions ?

I have to say I am not familar with 9P, but in our case we don't need to
launch
1000+ threads to read on files or open 1000+ fds to poll on them (we
literally
have that many properties!). We just process the data from the eventq. Also=
,
by using a single eventq, we are free from maintaining a data structure lik=
e
priority queue to make sure the data is processed in-order.

On Thu, Jun 10, 2021 at 9:06 AM Enrico Weigelt, metux IT consult <
lkml@metux.net> wrote:

> On 09.06.21 22:30, Hao Chen wrote:
> >  > Why not directly putting 9P links into virtio devices ?
> >
> > We have thought about using files to represent properties, but it turns
> > out we may need to subscribe to a large amount of
> > properties, so opening all of those files and polling is not ideal. Als=
o
> > the cross-property time-order matters in our case, so we abandoned this
> > idea.
>
> On 9P it would just be issuing one Tread per file you're intersted in
> (of course, after Rread comes in, you'll have to send it again, if you
> wanna continue to read).
>
> How is that so different from subscriptions ?
>
> --mtx
>
> --
> ---
> Hinweis: unverschl=C3=BCsselte E-Mails k=C3=B6nnen leicht abgeh=C3=B6rt u=
nd manipuliert
> werden ! F=C3=BCr eine vertrauliche Kommunikation senden Sie bitte ihren
> GPG/PGP-Schl=C3=BCssel zu.
> ---
> Enrico Weigelt, metux IT consult
> Free software and Linux embedded engineering
> info@metux.net -- +49-151-27565287 <+49%201512%207565287>
>

--000000000000feae4c05c47191df
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Stefan and Enrico,<br><br>&gt; What does &quot;share th=
e same configuration&quot; mean? ...<br><br>It means these values share the=
 virtio_parameter_server_prop_config.<br>So they will have the same mode (e=
.g., all of them are read-only and static).<br>Also they have the same enco=
ding rule, for example, each value contains one<br>64-bit integer and three=
 64-bit floating point numbers.<br><br>&gt; What are the units of this time=
stamp (nanoseconds, milliseconds,<br>&gt; seconds)?<br><br>I don&#39;t know=
 if I should define the unit, in our current usecase,<br>it can be unix tim=
estamp in milliseconds, but I don&#39;t know if it is<br>true for all poten=
tial usecases. Maybe in some cases there will not<br>be real-world timestam=
p but using sequential numbers instead. So I<br>leave it blank here. The re=
ason of having this field is the guest VM<br>userspace may need to know the=
 order of the generation of the data.<br>In some cases the guest userspace =
may also care about the real generation<br>time. Do you prefer having a cle=
arer definition here?<br><br>&gt; A common request layout for devices is:<b=
r>&gt; <br>&gt; =C2=A0struct request {<br>&gt; =C2=A0 =C2=A0 =C2=A0struct r=
equest_header header;<br>&gt; =C2=A0 =C2=A0 =C2=A0u8 data[];<br>&gt; =C2=A0=
 =C2=A0 =C2=A0struct request_footer footer;<br>&gt; =C2=A0};<br><br>I didn&=
#39;t see any &quot;footers&quot; in the current spec. Could you please exp=
lain more?<br><br>&gt; Can you rephrase the definition of MUTABLE? I don&#3=
9;t understand what it<br>&gt; means, especially since there is already a W=
RITE permission that<br>&gt; indicates read-only parameters. Why is MUTABLE=
 needed?<br><br>Write permission and mutable variables are different things=
. For example,<br>if we use a flag to indicate if it is sunny outside, we c=
annot write to it<br>since we cannot control the weather, but the value is =
definitely mutable<br>because weather may change.<br><br>&gt; Does CONTINUO=
US mean that the device expects to update the value?<br>&gt; ... =C2=A0then=
 PERIODIC might be a clearer name than CONTINUOUS<br><br>Both MUTABLE and C=
ONTINUOUS variables may be changed by the device,<br>but MUTABLE value chan=
ges usually represent async value updates (like<br>IP address changed, gear=
 switched, or weather changed, etc.), the value<br>need to be send to the d=
river in every updates; while CONTINOUS values<br>are more like rated senso=
r data.<br><br>&gt; &gt; +The properties with the same \field{prop_id} shar=
e the configuration.<br><br>&gt; It is not clear to mean what a &quot;confi=
guration&quot; is.<br><br>&quot;configuration&quot; means &quot;virtio_para=
meter_server_prop_config&quot;<br><br><br>&gt; &gt; \field{min_sample_freq}=
 and<br>&gt; &gt; +\field{max_sample_freq} are the sampling rate range for =
the<br>&gt; &gt; +\field{VIRTIO_PARAMETER_SERVER_M_CONTINUOUS} values.<br><=
br>&gt; Is this really needed since the device interface also supports pub/=
sub?<br><br>It is, those numbers indicate how fast the device will sample t=
he data for<br>the driver. The driver doesn&#39;t fetch the value at the ma=
x rate, it just check.<br><br>&gt; &gt; \field{desc} is<br>&gt; &gt; the op=
tional string<br>&gt; &gt; +description.<br><br>&gt; Is this the parameter&=
#39;s name (&quot;temperature_sensor_4&quot;) or is it a<br>&gt; descriptio=
n (&quot;Main board temperature sensor&quot;)?<br><br>What is the differenc=
e? The device use the prop_id to identify parameters<br>and this is for hum=
an anyways.<br><br>&gt; &gt; \field{params} are for the customized configur=
ation parameters.<br><br>&gt; This looks like a vendor-specific extension m=
echanism. It&#39;s opaque so<br>&gt; there&#39;s no way for the driver to s=
kip over parameters it doesn&#39;t<br>&gt; understand. That could be a prob=
lem for version compatibility if the<br>&gt; device/driver are updated and =
expect different param[] data formats.<br>&gt; Perhaps it would help to def=
ine the structure that allows the driver to<br>&gt; skip unknown parameters=
?<br><br>The driver does not care. The driver&#39;s behavior is nothing to =
do with the<br>configs. The configs are for the userspace to understand the=
 value it<br>receives. In each specific case, there will be some special &q=
uot;configs&quot; that<br>the userspace app may need to know, but the drive=
r is still act as a general<br>parameter server driver.<br><br>&gt; On 9P i=
t would just be issuing one Tread per file you&#39;re intersted in<br>&gt; =
(of course, after Rread comes in, you&#39;ll have to send it again, if you<=
br>&gt; wanna continue to read).<br><br>&gt; How is that so different from =
subscriptions ?<br><br>I have to say I am not familar with 9P, but in our c=
ase we don&#39;t need to launch<br>1000+ threads to read on files or open 1=
000+ fds to poll on them (we literally<br>have that many properties!). We j=
ust process the data from the eventq. Also,<br>by using a single eventq, we=
 are free from maintaining a data structure like<br>priority queue to make =
sure the data is processed in-order.<br></div><br><div class=3D"gmail_quote=
"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Jun 10, 2021 at 9:06 AM Enr=
ico Weigelt, metux IT consult &lt;<a href=3D"mailto:lkml@metux.net">lkml@me=
tux.net</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"=
margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-lef=
t:1ex">On 09.06.21 22:30, Hao Chen wrote:<br>
&gt;=C2=A0 &gt; Why not directly putting 9P links into virtio devices ?<br>
&gt; <br>
&gt; We have thought about using files to represent properties, but it turn=
s <br>
&gt; out we may need to subscribe to a large amount of<br>
&gt; properties, so opening all of those files and polling is not ideal. Al=
so <br>
&gt; the cross-property time-order matters in our case, so we abandoned thi=
s <br>
&gt; idea.<br>
<br>
On 9P it would just be issuing one Tread per file you&#39;re intersted in<b=
r>
(of course, after Rread comes in, you&#39;ll have to send it again, if you<=
br>
wanna continue to read).<br>
<br>
How is that so different from subscriptions ?<br>
<br>
--mtx<br>
<br>
-- <br>
---<br>
Hinweis: unverschl=C3=BCsselte E-Mails k=C3=B6nnen leicht abgeh=C3=B6rt und=
 manipuliert<br>
werden ! F=C3=BCr eine vertrauliche Kommunikation senden Sie bitte ihren<br=
>
GPG/PGP-Schl=C3=BCssel zu.<br>
---<br>
Enrico Weigelt, metux IT consult<br>
Free software and Linux embedded engineering<br>
<a href=3D"mailto:info@metux.net" target=3D"_blank">info@metux.net</a> -- <=
a href=3D"tel:+49%201512%207565287" value=3D"+4915127565287" target=3D"_bla=
nk">+49-151-27565287</a><br>
</blockquote></div>

--000000000000feae4c05c47191df--

