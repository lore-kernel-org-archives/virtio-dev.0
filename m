Return-Path: virtio-comment-return-1516-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
From: Jie Deng <jie.deng@intel.com>
References: <3b0fd676eed3baa775009a17047737dbe669594c.1604992813.git.jie.deng@intel.com>
 <83052aa7-8815-ce9d-3c9f-59d863107702@redhat.com>
 <20201110053225-mutt-send-email-mst@kernel.org>
 <5a0fcb8b-80a1-d1e0-5d9f-2f6cc003adc2@redhat.com>
 <616323bf-25a5-d951-cd4c-3d67f08f5af8@intel.com>
 <20201112035331-mutt-send-email-mst@kernel.org>
 <c5d080c1-5dcf-cc80-681c-5dae34797e9e@intel.com>
Message-ID: <ba89c7cc-fad4-e0ca-642a-220364ffd05a@intel.com>
Date: Mon, 16 Nov 2020 10:12:21 +0800
MIME-Version: 1.0
In-Reply-To: <c5d080c1-5dcf-cc80-681c-5dae34797e9e@intel.com>
Subject: Re: [virtio-comment] [PATCH v4] virtio-i2c: add the device
 specification
Content-Type: multipart/alternative;
 boundary="------------E5183AD944527EC4D021E898"
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, cohuck@redhat.com, wsa+renesas@sang-engineering.com, andriy.shevchenko@linux.intel.com, yu1.wang@intel.com, conghui.chen@intel.com, shuo.a.liu@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

--------------E5183AD944527EC4D021E898
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable

Hi Michael and Paolo,

Have you reached an agreement on the design of "virtio_i2c_req" ?

Personally, I think the design in v4 can already handle the=20
multi-segment transactions between frontend and backend.

Fore example, the frontend may kick the sequence "write read read ..."=20
to the backend at a time.

The segments can be aggregated into "i2c_msg list" and sent to the=20
hardware at a time by the backend.

The host native drivers will finally send these segments using the=20
methods they support.

Does this make sense ?

Thanks.


On 2020/11/13 10:39, Jie Deng wrote:
>
> On 2020/11/12 16:54, Michael S. Tsirkin wrote:
>> On Thu, Nov 12, 2020 at 09:51:17AM +0800, Jie Deng wrote:
>>> On 2020/11/10 18:59, Paolo Bonzini wrote:
>>>> On 10/11/20 11:33, Michael S. Tsirkin wrote:
>>>>>> Sorry I didn't reply last week, but I really would prefer if=20
>>>>>> virtio-i2c
>>>>>> supported write-read transactions.
>>>>> And I think an easier way is to allow multi-segment transactions
>>>>> probably using the stop flag.
>>>> You cannot always be sure that the host would support them (with the
>>>> exception of write+read transactions, which are pretty much=20
>>>> universal),
>>>> so you would also need to describe what the host features are.
>>>>
>>>> Paolo
>>>>
>>> Then I will send v5 to support write+read transactions using Paolo's
>>> proposal.
>>> I think we may have a simple version merged first and then improve it
>>> according
>>> to the actual needs.
>>>
>>> Thank you.
>> I frankly don't get it, you put read/write flags there even though they
>> are not needed, saying it's intended to mirror Linux, then don't want to
>> put STOP there even though this is exactly what Linux has ...
>
> Personally, I intended to mirror the Linux=C2=A0 "i2c_msg" to have=20
> following interface.
>
> struct virtio_i2c_req {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 le16 addr;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 le16 flags;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 le16 len;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u8 buf[];
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u8 status;
>
> };
>
> I intended to implement the standard rules for I2C transactions
> (no I2C_FUNC_PROTOCOL_MANGLING) for the first step. So in the
> v1~v3 only the "I2C_M_RD" was used and other bits of the flags were=20
> reserved.
> (I2C_M_STOP requires I2C_FUNC_PROTOCOL_MANGLING).
>
> For me, I intend to mirror the "i2c_msg" from the Linux completely.
>
> I learned about Michael also intends to keep above interface but want to
> remove some unnecessary bit (e.g. I2C_M_RD) from the flags (Correct me=20
> if not right).
>
> Paolo prefers following interface without flags.
>
> struct virtio_i2c_req {
> =C2=A0=C2=A0=C2=A0=C2=A0le16 addr;
> =C2=A0=C2=A0=C2=A0=C2=A0le16 written;
> =C2=A0=C2=A0=C2=A0=C2=A0le16 read;
> =C2=A0=C2=A0=C2=A0=C2=A0u8 bufwrite[];
> =C2=A0=C2=A0=C2=A0=C2=A0u8 status;
> =C2=A0=C2=A0=C2=A0=C2=A0u8 bufread[];
> };
>
> So Michael and Paolo, I hope we can agree on the interface first.
>
> Any suggestions ?
>
> Thanks.
>

--------------E5183AD944527EC4D021E898
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html>
  <head>
    <meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DUTF-8=
">
  </head>
  <body>
    <p>Hi Michael and Paolo,</p>
    <p>Have you reached an agreement on the design of "<span
        class=3D"fontstyle0">virtio_i2c_req"</span> ?</p>
    <p>Personally, I think the design in v4 can already handle the
      multi-segment transactions between frontend and backend.</p>
    <p>Fore example, the frontend may kick the sequence "write read read
      ..." to the backend at a time.</p>
    <p>The segments can be aggregated into "i2c_msg list" and sent to
      the hardware at a time by the backend.<br>
    </p>
    The host native drivers will finally send these segments using the
    methods they support. <br>
    <p>Does this make sense ?</p>
    <p>Thanks.<br>
    </p>
    <p><br>
    </p>
    <div class=3D"moz-cite-prefix">On 2020/11/13 10:39, Jie Deng wrote:<br>
    </div>
    <blockquote type=3D"cite"
      cite=3D"mid:c5d080c1-5dcf-cc80-681c-5dae34797e9e@intel.com">
      <br>
      On 2020/11/12 16:54, Michael S. Tsirkin wrote:
      <br>
      <blockquote type=3D"cite">On Thu, Nov 12, 2020 at 09:51:17AM +0800,
        Jie Deng wrote:
        <br>
        <blockquote type=3D"cite">On 2020/11/10 18:59, Paolo Bonzini
          wrote:
          <br>
          <blockquote type=3D"cite">On 10/11/20 11:33, Michael S. Tsirkin
            wrote:
            <br>
            <blockquote type=3D"cite">
              <blockquote type=3D"cite">Sorry I didn't reply last week,
                but I really would prefer if virtio-i2c
                <br>
                supported write-read transactions.
                <br>
              </blockquote>
              And I think an easier way is to allow multi-segment
              transactions
              <br>
              probably using the stop flag.
              <br>
            </blockquote>
            You cannot always be sure that the host would support them
            (with the
            <br>
            exception of write+read transactions, which are pretty much
            universal),
            <br>
            so you would also need to describe what the host features
            are.
            <br>
            <br>
            Paolo
            <br>
            <br>
          </blockquote>
          Then I will send v5 to support write+read transactions using
          Paolo's
          <br>
          proposal.
          <br>
          I think we may have a simple version merged first and then
          improve it
          <br>
          according
          <br>
          to the actual needs.
          <br>
          <br>
          Thank you.
          <br>
        </blockquote>
        I frankly don't get it, you put read/write flags there even
        though they
        <br>
        are not needed, saying it's intended to mirror Linux, then don't
        want to
        <br>
        put STOP there even though this is exactly what Linux has ...
        <br>
      </blockquote>
      <br>
      Personally, I intended to mirror the Linux=C2=A0 "i2c_msg" to have
      following interface.
      <br>
      <br>
      struct virtio_i2c_req {
      <br>
      =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 le16 addr;
      <br>
      =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 le16 flags;
      <br>
      =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 le16 len;
      <br>
      =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u8 buf[];
      <br>
      =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u8 status;
      <br>
      <br>
      };
      <br>
      <br>
      I intended to implement the standard rules for I2C transactions
      <br>
      (no I2C_FUNC_PROTOCOL_MANGLING) for the first step. So in the
      <br>
      v1~v3 only the "I2C_M_RD" was used and other bits of the flags
      were reserved.
      <br>
      (I2C_M_STOP requires I2C_FUNC_PROTOCOL_MANGLING).
      <br>
      <br>
      For me, I intend to mirror the "i2c_msg" from the Linux
      completely.
      <br>
      <br>
      I learned about Michael also intends to keep above interface but
      want to
      <br>
      remove some unnecessary bit (e.g. I2C_M_RD) from the flags
      (Correct me if not right).
      <br>
      <br>
      Paolo prefers following interface without flags.
      <br>
      <br>
      struct virtio_i2c_req {
      <br>
      =C2=A0=C2=A0=C2=A0=C2=A0le16 addr;
      <br>
      =C2=A0=C2=A0=C2=A0=C2=A0le16 written;
      <br>
      =C2=A0=C2=A0=C2=A0=C2=A0le16 read;
      <br>
      =C2=A0=C2=A0=C2=A0=C2=A0u8 bufwrite[];
      <br>
      =C2=A0=C2=A0=C2=A0=C2=A0u8 status;
      <br>
      =C2=A0=C2=A0=C2=A0=C2=A0u8 bufread[];
      <br>
      };
      <br>
      <br>
      So Michael and Paolo, I hope we can agree on the interface first.
      <br>
      <br>
      Any suggestions ?
      <br>
      <br>
      Thanks.
      <br>
      <br>
    </blockquote>
  </body>
</html>

--------------E5183AD944527EC4D021E898--

