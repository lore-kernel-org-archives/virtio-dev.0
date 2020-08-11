Return-Path: virtio-dev-return-7634-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 21183985A89
	for <virtio-dev@lists.oasis-open.org>; Tue, 11 Aug 2020 17:10:17 +0000 (UTC)
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue, 11 Aug 2020 18:10:12 +0100
Message-ID: <87sgct153f.fsf@linaro.org>
MIME-Version: 1.0
Subject: [virtio-dev] clarifying the handling of responses for virtio-rpmb
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
To: virtio-dev@lists.oasis-open.org, virtualization@lists.linuxfoundation.org
Cc: Tomas Winkler <tomas.winkler@intel.com>, Yang Huang <yang.huang@intel.com>, "Zhu, Bing" <bing.zhu@intel.com>, "Michael S.Tsirkin" <mst@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>


Hi,

The specification lists a number of commands that have responses:

  The operation of a virtio RPMB device is driven by the requests placed
  on the virtqueue. The type of request can be program key
  (VIRTIO_RPMB_REQ_PROGRAM_KEY), get write counter
  (VIRTIO_RPMB_REQ_GET_WRITE_COUNTER), write
  (VIRTIO_RPMB_REQ_DATA_WRITE), and read (VIRTIO_RPMB_REQ_DATA_READ). A
  program key or write request can also combine with a result read
  (VIRTIO_RPMB_REQ_RESULT_READ) for a returned result.

Now I'm deep in the guts of virt queues doing the implementation I'm
trying to clarify exactly what frames should be sent to the device and
if they should be out_sgs or in_sgs. I suspect there is some difference
between the original prototype interface and what we have now.

Some operations obviously have an implied response
(VIRTIO_RPMB_REQ_GET_WRITE_COUNTER and VIRTIO_RPMB_REQ_DATA_READ). As
far as I could tell the frame should be simple:

  sg[0] (out_sg=3D1) - frame with command
  sg[1..n] (in_sg=3D1..n) - space for the reply to be filled in by the devi=
ce

However the language for the program key and data write say they can be
combined with a VIRTIO_RPMB_REQ_RESULT_READ to optionally return a
result. My question is is this result read meant to be in a separate
request frame and response frame so you get:

 sg[0] - VIRTIO_RPMB_REQ_PROGRAM_KEY/VIRTIO_RPMB_REQ_DATA_WRITE frame
 sg[1] - VIRTIO_RPMB_REQ_RESULT_READ (out_sg=3D2)
 sg[2] - empty frame for response (in_sg=3D1)

or:

 sg[0] - VIRTIO_RPMB_REQ_PROGRAM_KEY/VIRTIO_RPMB_REQ_DATA_WRITE frame (out_=
sg=3D1)
 sg[1] - VIRTIO_RPMB_REQ_RESULT_READ (in_sg=3D1)

where the result frame is filled in and sent back?

I must say I'm a little confused by the logic in rpmb_ioctl (in the
userspace tool) which creates both out_frames and resp frames:

  static int rpmb_ioctl(uint8_t frame_type, int fd, uint16_t req,
                        const void *frames_in, unsigned int cnt_in,
                        void *frames_out, unsigned int cnt_out)
  {
          int ret;
          struct __packed {
                  struct rpmb_ioc_seq_cmd h;
                  struct rpmb_ioc_cmd cmd[3];
          } iseq =3D {};

          void *frame_res =3D NULL;
          int i;
          uint32_t flags;

          rpmb_dbg("RPMB OP: %s\n", rpmb_op_str(req));
          dbg_dump_frame(frame_type, "In Frame: ", frames_in, cnt_in);

          i =3D 0;
          flags =3D RPMB_F_WRITE;
          if (req =3D=3D RPMB_WRITE_DATA || req =3D=3D RPMB_PROGRAM_KEY)
                  flags |=3D RPMB_F_REL_WRITE;
          rpmb_ioc_cmd_set(iseq.cmd[i], flags, frames_in, cnt_in);
          i++;

          if (req =3D=3D RPMB_WRITE_DATA || req =3D=3D RPMB_PROGRAM_KEY) {
                  frame_res =3D rpmb_frame_alloc(frame_type, 0);
                  if (!frame_res)
                          return -ENOMEM;
                  rpmb_frame_set(frame_type, frame_res,
                                 RPMB_RESULT_READ, 0, 0, 0);
                  rpmb_ioc_cmd_set(iseq.cmd[i], RPMB_F_WRITE, frame_res, 0)=
;
                  i++;
          }

          rpmb_ioc_cmd_set(iseq.cmd[i], 0, frames_out, cnt_out);
          i++;

          iseq.h.num_of_cmds =3D i;
          ret =3D ioctl(fd, RPMB_IOC_SEQ_CMD, &iseq);
          if (ret < 0)
                  rpmb_err("ioctl failure %d: %s.\n", ret, strerror(errno))=
;

          ret =3D rpmb_check_req_resp(frame_type, req, frames_out);

          dbg_dump_frame(frame_type, "Res Frame: ", frame_res, 1);
          dbg_dump_frame(frame_type, "Out Frame: ", frames_out, cnt_out);
          free(frame_res);
          return ret;
  }

although I'm guessing this might just be an impedance between the
chardev ioctl interface for rpmb and the virtio FE driver which is only
one potential consumer of these rpmb ioc commands?=20

Can anyone clarify?

--=20
Alex Benn=C3=A9e

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

