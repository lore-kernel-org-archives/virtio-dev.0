Return-Path: <virtio-dev-return-11472-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB08EC678D5
	for <virtio-dev@archiver.kernel.org>; Tue,  7 Mar 2023 10:32:06 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 167372A8EF
	for <virtio-dev@archiver.kernel.org>; Tue,  7 Mar 2023 10:32:06 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 04CF29866CF
	for <virtio-dev@archiver.kernel.org>; Tue,  7 Mar 2023 10:32:06 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id ED2659866C3; Tue,  7 Mar 2023 10:32:05 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D899C9866C2;
	Tue,  7 Mar 2023 10:32:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e0f7WsIgORu3SLCOutNXvRhhUM07V0bGaNKRdKw5Gd2WVRCdP6LDyaa8PCFl4nzAvaKcO7Za5ZK3YZof5zZYO43smI6MRBI3WZvlSLkqxO9S7MnGsvD3c6Z/E1fZ8MkUmmnfBEF5o26SlvDCXJ+6nmem8ubHGcqlKNjAxQdjAnIk6+u7VxP8jMM7N8uHzIIDmFh1rzQIYYbvOu2tarzHIxNUUeOwAoJUzHKgzAlPtTs8miYRe6si3ygNx9k5MKKiVw4WXCuo9sVoFuVNf/bOL/Y51q98ceKdsEVlpBDxN2s83uUM//uyjRGMLb1gpPoJ14IJ8igofNCnVHvpeenSsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rzkt3sEnzqxOeY8j4tCmNmL88gor37qANFcioFcwdZw=;
 b=Z0n8N6RZfRci6sp3V7l3BSVpI3HlZGXajAvq1hQ074Vglc0hi8HP5qffpdujhV8adTGMll2wyBsdLg0ZI7uilO6EIY9fWgAZyd4jpdr+8IGEU4jtuChq55FClVlStQThSuA90nYI0BBfvsJZXALhOzWZMO90Seg31L0i47VEhtQz67gJodzEpl7JeFNrqI5HiA/4I43mLLeMQ0BRZOAyd9UDD7pjGbNmx4yC5aBSpngOT0jP9LThyf1o48QCubJotqqDzmpxKNGZRK1jNbrsMHkH59tsmQVB+b3TWaGUPt1nlETEPaG0yi7V8Rd71bzvNbicR+F/r7w2OdRM56NLxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
From: David Edmondson <david.edmondson@oracle.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, virtio-comment@lists.oasis-open.org,
        virtio-dev@lists.oasis-open.org, jasowang@redhat.com, mst@redhat.com,
        cohuck@redhat.com, sgarzare@redhat.com, stefanha@redhat.com,
        nrupal.jani@intel.com, Piotr.Uminski@intel.com, hang.yuan@intel.com
Cc: virtio@lists.oasis-open.org, Zhu Lingshan <lingshan.zhu@intel.com>,
        pasic@linux.ibm.com, Shahaf Shuler <shahafs@nvidia.com>,
        Parav Pandit
 <parav@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <910b3607a5f255134d30b3e1233e564f564eafb8.1677761896.git.mst@redhat.com>
References: <cover.1677761896.git.mst@redhat.com>
 <910b3607a5f255134d30b3e1233e564f564eafb8.1677761896.git.mst@redhat.com>
Date: Tue, 07 Mar 2023 10:31:47 +0000
Message-ID: <m2lek8zwbw.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: AM3PR07CA0105.eurprd07.prod.outlook.com
 (2603:10a6:207:7::15) To DS7PR10MB4926.namprd10.prod.outlook.com
 (2603:10b6:5:3ac::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB4926:EE_|CH3PR10MB7396:EE_
X-MS-Office365-Filtering-Correlation-Id: 34bb5a5d-000b-413a-f93c-08db1ef72b9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	doP37A73yD7zGhJy9oJ/+cZe8GUxgJwHcFmf2TDBc9FdrQ/dO7uFRh46wwEK9czs2HG/wEdYKF1Migvun5EHtKsIiHfdTrFmvFBpZyUUkEeTMqeUAqT5ih1zw50GV8RJ4aFwe0pXWXjYFOvI16dxrjzOCU3Hxv9Rg6miqlryd1D5kX3QjG7YNla75HcaHIvkjxjPEHOet+lxyCBptc6pjV1mp0BRs7/dL9mcNUklK685lQ2iIDy/+g8Lfuutp+0gfWQZUvWp+B/ITRoOE9FiC6/yXDz8snjnOBAKNbJwdw5o8MkXDTkH15M1ad4W01Sq5GddLx/SP3Piy7xvgtw7IBlYxi3I8ifkI6BTNM2nVz8Akh/t5qVHHqGOlgR+jr5pAW7TdSa3rQJc2U3szaV1zgaxbb2ZZhwzL7ROQW+A5HrNu/mNvERb1eu35msRaQBiRWG0KEsDyPLzXjg/W/kthVz4zNh6c8G0hz6Zaam+dcir7/UBl+EYB1i7O6/87SzyI8naico9fIfzb0nF8stKE0R3pHEmxfTtD+GKCR30pdOs7lNJXdrowcudEv+fQ9skSYWRHI3g+OLUnzh+KM+q8JEPIGyaHOS16elkZX7EdUFpLmdLZTr+hbpf1u0uAxvuEHt8Fmd/1y4CJVi6aDQZu7POmYJjT4Y7o23MolTb0Dhe3VGZKLrkNSn/AS01UC9A+idqUhRTMoj41cdye+vWOA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB4926.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(376002)(396003)(39860400002)(366004)(136003)(451199018)(66899018)(66476007)(8676002)(66946007)(41300700001)(4326008)(66556008)(44832011)(7416002)(2906002)(5660300002)(921005)(86362001)(16799955002)(36756003)(38100700002)(8936002)(966005)(6486002)(478600001)(6666004)(316002)(6506007)(2616005)(54906003)(26005)(186003)(6512007)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?IOTE4/Icf1IkiYWIcR5IJqGh0TJBu8OcagYxclACjXuujeYjDvriaWXQN6Mn?=
 =?us-ascii?Q?syT2B7tGDZkAsGtCwToZjwOIItUV+h7qW2bQ5Y9UShXH+ck0Fd++fzDIuiQV?=
 =?us-ascii?Q?AgXPF/XQ0qsAX1MIBbycjiBV3sATL+RcetiMG4UvEvRcrLQXPgYBJ0h4y8Ka?=
 =?us-ascii?Q?RY1yAiKXNEltBCtzGXKQYKDGaW7JrmeNv6/RN8eIejiPQ+TgbJDVaEXMvzlT?=
 =?us-ascii?Q?SSQWjb1jrdJnjzB9DwkIpJYZ5W/tG6IPCU1HMUSbLqsDO//VzX0NI7wDnvIR?=
 =?us-ascii?Q?3Gvm0u9jyRzT5/xXKnZzMK0iB3E1/HpeC3Dho8HWQ9rsx/hnAKf591OA2us6?=
 =?us-ascii?Q?Tx9lmY5fROPRKqCrSRFAL1ebmqxdP0PdYijPvQ/u+zHndW5poKc//TyGQSEL?=
 =?us-ascii?Q?xY3CmiZESsPxKE0C/wbOr8/Odm4zcKwULEpI0aX/B1JeQHLX5FF8eWz8+LeW?=
 =?us-ascii?Q?vZbCxGbA7KmZG9Gxq36k5Xyeria+y4maAif14nXtNKTFi1fHLbAglnfPry8l?=
 =?us-ascii?Q?Nm8eTub/eyWv2/ebFCQx7fRPs+nFgW4wdK9KRea5O58/C60XJbBDvqq1tSD6?=
 =?us-ascii?Q?WkBBROAfH1wy9Kv6h+mbqe3+fs8Emv/PeEdKeEC8xZIZ75DPSrK2NXGZItMh?=
 =?us-ascii?Q?CEqq/sfoxyWt0ePjK8CDPnYCUQ/W6FGfXTRgADHpSF0NLlxHcN2K6lGufD1O?=
 =?us-ascii?Q?MDUM49vf+5feDnV7+6lmHaThZKYitU1vUAbij+rzcM/2rmCo9DFq8ORJj/pE?=
 =?us-ascii?Q?o35FkzjkU8fsojBSNx9xE7jRJHJub21gc+yDYgZ25yyGeMtGWZ+gxpe/ztHC?=
 =?us-ascii?Q?41c4XbpWTR6KxGG57jiVOT/wGkmxudL6hdNNLLxOHDpubLQoqImn4eLUol0j?=
 =?us-ascii?Q?YX2VW6KcH6xtwpzTAE43eQG0kEkOBhDGeHcSRhPor1deqkyxpu6elZUTAxLT?=
 =?us-ascii?Q?iR+w0j3MIFAyO8SCtM/JAMTeBgxgaV3c2e30CYZ02nVBx77kbWDJLfjyPgxt?=
 =?us-ascii?Q?cE+xJWh3grOerb7Z1MLCpSncEipyXEcS2CyUEvh/ZH+kl+aFuDCVlbQtneh5?=
 =?us-ascii?Q?qd3Pm6uoA8JF6FkDaOaxbe20pXZ/PVejSIR29/BgCORfASp3jIMJTw+Eog2t?=
 =?us-ascii?Q?OL0u0nMQS5BGjkT/k6mBMtolGpg8eKHsEE6sAcXe46OK7uMtKwslh9hJ+PuP?=
 =?us-ascii?Q?8Kukd+kOm1/0q5G5BwAyZ3CO0c134N9N/vEHjorrjdvQayzQqSCEsxEDbfrk?=
 =?us-ascii?Q?oUxDKmOgmGvM1zcs3PMKWoMQYTvEqCJH+RJcAMnHNHZEyjDMNzra6mOh6PEx?=
 =?us-ascii?Q?65cIf8xVNWj0HABdHV9dba3gukb5f3qWj53jUH5ghvxfAYPUja2eRWnBiv3F?=
 =?us-ascii?Q?i6/qF1DIRkWG0bNwvFv8wyrldKVmKSiANl7EulTpjLgieeUNza+ug1o0X1Lz?=
 =?us-ascii?Q?WRuBJph5QeavG6WVD4+sakZ9lzXQTxpatHVD8vGEWfk1VYqM0yAwl/K5oRUa?=
 =?us-ascii?Q?JcKOnoZTKJlLCoh4n3vIHmD2mWyI5ZJcERQlyaWbzrXwUE61vIHw/qlxnNe+?=
 =?us-ascii?Q?Hpp/kEU7zhKeSxO2L4Hhcxk6Bv0C0mj24Owi04DzhovwlyPkT96jjJLpmxbw?=
 =?us-ascii?Q?dA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	MOErDhEY9SQFHiN7wtyWashA6c/jqLPjVPksDGejqEXui3JHiEFG313xcpEVoIB0Kh/2/+ROZAY7qPjTlIgGCHW4ChvIbZsNtWD51Z0NVn0rG+jSKs/dDIpgqQrItGKX0l7fOQD81ua5gg2IBITgGm0wdOtkj2IPq/im/avEwer22BQe0tM/umTUyysYWyFKYkvHJ+L0JkzBD9/mN1x4vuAdW17mhjGbpYghlgosvvRwmjJDBziQ3l8EL2GdvLPfxgfjX+P2XJNPiBZ4ZPSoil2xNkkkyMD0MXaSI6OIVtYBFdYnF1GB2fYMPwcMEc5uyXmac6CfgPv5higN4TPI/o2R15md8U+YZtlzF6jdAL1vBE252UJgeIMyIFbT4boAXjTO7ih8kd8M0o9bF2UTyVb0Lnr/wIf3ftqpcjcd+TNkM2mPPpIxwr/SuPFv/H/H12F7TL5XzhtwjMNRtvwD5jgP5NwWo4W+guKHWfR8rlmKpbLGL7qcJChahmf56wq9FOGE02iQZzNduujVr2BTmkQNtyNZuWBbClie6FUQFE/e+UFoivftUYLPdY9bMRw50W1k4IdB4BTqYZv1cfJpxqd6CPPSg9WFrI8hrwqXS1IYtPZMzqexPD+IC2YL6arHuD6K2y9YyW+TvOFNO5dPF8mQEUD0VJqT8OAhoFf2rqsLeOOv0xcFI0VAQ3ak9bXNtmwPDVD+Ag2ZvLocwlyowtZVXzaAiBiony47k+NlJtVsfySqk+QWhQ4bRdH7dWQGiF2C0WsYwjfxKu+bYirXXShcR1lx9DLoRoM3KTDFPGsCX5L0PG6EclAt+KoDnY9ioel5JG/nQ+N9RZurESbl+zLQcUDwE4htVejHL+Ov+xTit7liDZPUQ5S5xJvCjNQx5qmRmlmta2leNEEbKhrL+Q==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34bb5a5d-000b-413a-f93c-08db1ef72b9a
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB4926.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2023 10:31:54.3057
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ni2wyIIblaYDA2X3qgxSTJCn72JtOWsmq+Q2COrskuveqEBHHH6RU7e9O161f0MlgVyu/mnpMCPW7R/XVQ+g8L5WE4zkaVT6WjxF3f1XBqI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7396
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-07_04,2023-03-07_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 adultscore=0
 spamscore=0 suspectscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303070094
X-Proofpoint-GUID: CCOMQwtAttSpt2PfemX6L-XyqSvXbPHP
X-Proofpoint-ORIG-GUID: CCOMQwtAttSpt2PfemX6L-XyqSvXbPHP
Subject: [virtio-dev] Re: [virtio] [PATCH v10 03/10] admin: introduce group
 administration commands

"Michael S. Tsirkin" <mst@redhat.com> writes:

> This introduces a general structure for group administration commands,
> used to control device groups through their owner.
>
> Following patches will introduce specific commands and an interface for
> submitting these commands to the owner.
>
> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  admin.tex        | 108 +++++++++++++++++++++++++++++++++++++++++++++++
>  introduction.tex |   3 ++
>  2 files changed, 111 insertions(+)
>
> diff --git a/admin.tex b/admin.tex
> index 3dc47be..7e28b77 100644
> --- a/admin.tex
> +++ b/admin.tex
> @@ -46,4 +46,112 @@ \section{Device groups}\label{sec:Basic Facilities of a Virtio Device / Device g
>  PCI transport (see \ref{sec:Virtio Transport Options / Virtio Over PCI Bus}).
>  \end{description}
>  
> +\subsection{Group administration commands}\label{sec:Basic Facilities of a Virtio Device / Device groups / Group administration commands}
>  
> +The driver sends group administration commands to the owner device of
> +a group to control member devices of the group.
> +This mechanism can
> +be used, for example, to configure a member device before it is
> +initialized by its driver.
> +\footnote{The term "administration" is intended to be interpreted
> +widely to include any kind of control. See specific commands
> +for detail.}
> +
> +All the group administration commands are of the following form:
> +
> +\begin{lstlisting}
> +struct virtio_admin_cmd {
> +        /* Device-readable part */
> +        le16 opcode;
> +        /*
> +         * 1 - SR-IOV
> +         * 2 - 65535 reserved

As before, this formatting is potentially confusing. There should be a
difference between "value X has meaning Y" and "a range from X to Y".

> +         */
> +        le16 group_type;
> +        /* unused, reserved for future extensions */
> +        u8 reserved1[12];
> +        le64 group_member_id;
> +        u8 command_specific_data[];
> +
> +        /* Device-writable part */
> +        le16 status;
> +        le16 status_qualifier;
> +        /* unused, reserved for future extensions */
> +        u8 reserved2[4];
> +        u8 command_specific_result[];
> +};
> +\end{lstlisting}
> +
> +For all commands, \field{opcode}, \field{group_type} and if
> +necessary \field{group_member_id} and \field{command_specific_data} are
> +set by the driver, and the owner device sets \field{status} and if
> +needed \field{status_qualifier} and
> +\field{command_specific_result}.
> +
> +Generally, any unused device-readable fields are set to zero by the driver
> +and ignored by the device.  Any unused device-writeable fields are set to zero
> +by the device and ignored by the driver.
> +
> +\field{opcode} specifies the command. The valid
> +values for \field{opcode} can be found in the following table:
> +
> +\begin{tabular}{|l|l|}
> +\hline
> +opcode & Name & Command Description \\
> +\hline \hline
> +0x0000 - 0x7FFF & - &  Group administration commands    \\
> +\hline
> +0x8000 - 0xFFFF & - & Reserved    \\
> +\hline
> +\end{tabular}
> +
> +The \field{group_type} specifies the group type identifier.
> +The \field{group_member_id} specifies the member identifier within the group.
> +See section \ref{sec:Introduction / Terminology / Device group}
> +for the definition of the group type identifier and group member
> +identifier.
> +
> +The following table describes possible \field{status} values;
> +to simplify common implementations, they are intentionally
> +matching common \hyperref[intro:errno]{Linux error names and numbers}:
> +
> +\begin{tabular}{|l|l|l|}
> +\hline
> +Status (decimal) & Name & Description \\
> +\hline \hline
> +00   & VIRTIO_ADMIN_STATUS_OK    & successful completion  \\
> +\hline
> +22   & VIRTIO_ADMIN_STATUS_EINVAL    & invalid command \\
> +\hline
> +other   & -    & group administration command error  \\
> +\hline
> +\end{tabular}
> +
> +When \field{status} is VIRTIO_ADMIN_STATUS_OK, \field{status_qialifier}

"status_qualifier"

> +is reserved and set to zero by the device.
> +
> +When \field{status} is VIRTIO_ADMIN_STATUS_EINVAL,
> +the following table describes possible \field{status_qialifier} values:
> +\begin{tabular}{|l|l|l|}
> +\hline
> +Status & Name & Description \\
> +\hline \hline
> +0x00   & VIRTIO_ADMIN_STATUS_Q_INVALID_COMMAND   & command error: no additional information  \\
> +\hline
> +0x01   & VIRTIO_ADMIN_STATUS_Q_INVALID_OPCODE    & unsupported or invalid \field{opcode}  \\
> +\hline
> +0x02   & VIRTIO_ADMIN_STATUS_Q_INVALID_FIELD    & unsupported or invalid field within \field{command_specific_data}  \\
> +\hline
> +0x03   & VIRTIO_ADMIN_STATUS_Q_INVALID_GROUP    & unsupported or invalid \field{group_type} \\
> +\hline
> +0x04   & VIRTIO_ADMIN_STATUS_Q_INVALID_MEMBER    & unsupported or invalid \field{group_member_id} \\
> +\hline
> +0x05-0xFFFF   & -    & reserved for future use \\
> +\hline
> +\end{tabular}
> +
> +Each command uses a different \field{command_specific_data} and
> +\field{command_specific_result} structures and the length of
> +\field{command_specific_data} and \field{command_specific_result}
> +depends on these structures and is described separately or is
> +implicit in the structure description.

Would it make sense to add some advisory text about alignment of the
fields after command_specific_data? It would be annoying if status,
status_qualifier, etc. were poorly aligned for a common hardware
implementation.

> diff --git a/introduction.tex b/introduction.tex
> index 287c5fc..0d849a9 100644
> --- a/introduction.tex
> +++ b/introduction.tex
> @@ -68,6 +68,9 @@ \section{Normative References}\label{sec:Normative References}
>  	\phantomsection\label{intro:FUSE}\textbf{[FUSE]} &
>  	Linux FUSE interface,
>  	\newline\url{https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/uapi/linux/fuse.h}\\
> +	\phantomsection\label{intro:errno}\textbf{[errno]} &
> +	Linux error names and numbers,
> +	\newline\url{https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/uapi/uapi/asm-generic/errno-base.h}\\
>          \phantomsection\label{intro:eMMC}\textbf{[eMMC]} &
>          eMMC Electrical Standard (5.1), JESD84-B51,
>          \newline\url{http://www.jedec.org/sites/default/files/docs/JESD84-B51.pdf}\\
> -- 
> MST
>
>
> ---------------------------------------------------------------------
> To unsubscribe from this mail list, you must leave the OASIS TC that 
> generates this mail.  Follow this link to all your TCs in OASIS at:
> https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php 
-- 
There is one bird in my house.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

