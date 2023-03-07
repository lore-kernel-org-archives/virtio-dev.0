Return-Path: <virtio-dev-return-11488-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE8EAC678D5
	for <virtio-dev@archiver.kernel.org>; Tue,  7 Mar 2023 18:26:44 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id F14A633099
	for <virtio-dev@archiver.kernel.org>; Tue,  7 Mar 2023 18:26:43 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id EB2D69866F9
	for <virtio-dev@archiver.kernel.org>; Tue,  7 Mar 2023 18:26:43 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id DF7C59866D1; Tue,  7 Mar 2023 18:26:43 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id CA4D99866D0;
	Tue,  7 Mar 2023 18:26:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XI6vvb9V6eX5R0fPM8A0GtUQPIURqiOT4nnAYHepL2UFWR7AW2EmWByowT34txur7F7OgmguT6DAhjozJ3yHiCfRZo0P3uqsdpFi/WIOYRBURVP4prwMKxwxCZbm5lHg8KYInqxOdGEOePyWBJcll2Kkpa20SsLOIotp295G1ZvmhGLSg5IbaTVO038WeOihxvbtcmAHYg314mmGMcBV+19AO2GQe+lcVjQLV7kXrRvKLTyXEMjkiOtYIe0OFjbr0tZeECUJwmbmvLDX45oqZjh5plueaG4wAJ3tgyG+oLJ4n+hRh9OUzM2yuliGNUlUafzgbLWcifDn9P9hbWAKNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MruIA6gulMzcTcCaZx2K3jdgYrT+5wSvm1WYWQYp0xc=;
 b=L0I9IEF44NOJSOt27CWj1/lBRgJ6Hk3/CnL7UvIaCjf2Yd0Na2qVMDOSPmEe6n9Vr3wgtzjS9qnJDicMuLcNpFUelXAJa5DCJiZ+uNns6/XTzNF5AacgTJ2rB0V0Q73zP67Brvm6bH5ZiQmsmec897k2d7EFH/Y9MF7jRhKt7u/y63U5RpkRoxfs/sIpgtk+m3n4dg0rbiak6d6sujL8YNPchMh6ybNG0tkWgK1d6lJe/EKAnjViGu4RURIqGMoilRFTKro1cyj1XdgFauboqucmfFu63bgL57cYQIqjL4ueKX/6WDJyC611oAbF4zszTG+5rgQyDotg3Rem4IeIcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: "virtio-comment@lists.oasis-open.org"
	<virtio-comment@lists.oasis-open.org>, "virtio-dev@lists.oasis-open.org"
	<virtio-dev@lists.oasis-open.org>, "jasowang@redhat.com"
	<jasowang@redhat.com>, "cohuck@redhat.com" <cohuck@redhat.com>,
	"sgarzare@redhat.com" <sgarzare@redhat.com>, "stefanha@redhat.com"
	<stefanha@redhat.com>, "nrupal.jani@intel.com" <nrupal.jani@intel.com>,
	"Piotr.Uminski@intel.com" <Piotr.Uminski@intel.com>, "hang.yuan@intel.com"
	<hang.yuan@intel.com>, "virtio@lists.oasis-open.org"
	<virtio@lists.oasis-open.org>, Zhu Lingshan <lingshan.zhu@intel.com>,
	"pasic@linux.ibm.com" <pasic@linux.ibm.com>, Shahaf Shuler
	<shahafs@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
Thread-Topic: [PATCH v10 03/10] admin: introduce group administration commands
Thread-Index: AQHZTQeefL6YcT/2+0WEizoMfiOaWK7ny5BAgABc9oCAB4EWEA==
Date: Tue, 7 Mar 2023 18:26:35 +0000
Message-ID:
 <PH0PR12MB5481C73CE3AD0AA918A3DB41DCB79@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <cover.1677761896.git.mst@redhat.com>
 <910b3607a5f255134d30b3e1233e564f564eafb8.1677761896.git.mst@redhat.com>
 <PH0PR12MB548116853CAC23DF9CA7345EDCB29@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230302184447-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230302184447-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|CY5PR12MB6454:EE_
x-ms-office365-filtering-correlation-id: 2ba8a4de-1e86-41f5-f4a6-08db1f397c2d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 jrb0dIgh7URsSr8Z0xU2QTetDm3sbIT+pDdKXn6d4lXQXmDdeJetTVo9VgTiTxObvYNI/6kSjy9dz+pHqBocrAT1HVqacUYfEMT1WWw2J/+gwvtIJVaaEWvuKvHcPAJjTR8238S9zhutEfzNE9JClQxMO+NScLfhQ4+fxsllyScws2Yau2AoTRXi0mKqHXPfiDL1dYm6Es1eh6ZKU7jBQmsy/31R3L+8XYNMuEtCF3/xJog32l1FB+0quf4298G0IzGmdjQ0uIQfL3karw4fjEueopQgfZc/ujR7p0yhGgYIZW+Gah2ps/NgJOVEGt5uiWdVjQuGNS192vMRquK2QQRUGts8uu6W3zEByb7ps+rbXq+/iH1ka1ZPqZKtR3gyDIQezs4PlTlrUBfxJ05yDeq4rPHWdLHMChTB+4z+RBE/peG+ZJxkAsnIcJQiNT+6jQeM9czVle3+IhVv4VeE0QWhOkU/dBdguTJ8a+1p+mFZnN3AIygFXxWTL5FSWA3sYQD2UacmH8/wgi8Uo8Aj9E5Mw9oN4DFSWMHIoSX0QgsH8h5lz0bAprfMFhjlFIyRsYleECufGQxciWLZufWIm3FMcsnwZDrlOus+Ky49SRWuDFXanTA7ey87VF9s8f4BYJhPuiapHkGeDmE3sZX8Aaf0GPO0zBrXRLiYk366fm0ho9NrXebEZUUUi0xu5R5X251ni1AP6ommpovsuBVYrA==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(136003)(376002)(346002)(396003)(39860400002)(451199018)(38100700002)(107886003)(8676002)(66476007)(64756008)(41300700001)(66556008)(76116006)(4326008)(66446008)(66946007)(33656002)(5660300002)(6916009)(54906003)(83380400001)(86362001)(7416002)(316002)(4744005)(52536014)(8936002)(122000001)(38070700005)(2906002)(478600001)(71200400001)(55016003)(7696005)(6506007)(26005)(186003)(9686003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?AAQuAHli6WMVHForAopxo+Tjxu5W72LtmuCygJZHXJeZk00IgUI0wSKi7SFL?=
 =?us-ascii?Q?EblFQC6lLHgraToqKjxemZguu/qTNs371s0Ni+e+ye1x3KULhg0vmw+s0e5+?=
 =?us-ascii?Q?c2Wa7V7dVEWyKsmmib8zk/PVi3kolezf7+OF3VAtVCONPPgtOWleXod+WkGM?=
 =?us-ascii?Q?iLlxda+4FIkniuM/RaZygH5s8oymQQeck+mrLtA96kI+w0ubuN81R7uL2Dr5?=
 =?us-ascii?Q?kvOCrvrSN++OrvOotgiQeX+MsJGbXbKGi6W8KAn5sdETdaZxmJBOyOrd2YKj?=
 =?us-ascii?Q?O4Vn9v81x0X2VeWvdVJZug/f+KPWA/n2fpdP+ddHOrE/JKY8ZjBA40ay6FjY?=
 =?us-ascii?Q?5U5uuSuhqG2HYJpId2WK50zpsrYKyy4qN+vJZmL05QHw8GSodQLQ+J2/tRsu?=
 =?us-ascii?Q?ihxKztCfbr09TY2bpdQWu0sc5E6DvEyRK5otk6noheqTdbTuOhWwKgJFXX9q?=
 =?us-ascii?Q?7o0OzFKZovNJOOoX7IpSsd0DSqXvsoJtwYh6rXwKZeWRviAGwnUZeg8x5zoK?=
 =?us-ascii?Q?Rlz4NWBL4prao4Qzfve3kawOjinD5vh/cKCDtjJhQqGrlCNwH2Z4vtbVSctO?=
 =?us-ascii?Q?sMrr7iRevv9Fp8PaeFVopz3ylkxpvd6Uqb1l3uHRq296v34cxT1pXDAX9yKa?=
 =?us-ascii?Q?71jhipcu7wgDoY9834m9k5RgzdbuhAdrCRUkUbYAT/+NHbPxAIERfYApCIqW?=
 =?us-ascii?Q?dqO49Jt+Um4c3qnU4O4r2UykgF4HNc5jX45gB8x6q/dUD1cGezv3kq2nm/c8?=
 =?us-ascii?Q?jVI8SwczsP3PjnEBFhbzl5epLgCpZJ1YCZrS59NuaUY/rHCswitJ9j7czz9T?=
 =?us-ascii?Q?xyOCB1JtsnJnaiYU09TRGOD/4BOksRKxLxoovBW6P6J0rkdftOeXc92+aN+C?=
 =?us-ascii?Q?aDWD+n8rSFU/xOhMtcWKw/Hgl4yBix0FRQi1Zx7dFZTvl8PPStiE6zJVaeqo?=
 =?us-ascii?Q?NZqOXLjlT3Q2AS+o4aIa57SZRqjK3ZBWEP6LpmSqyaEUAbAGcZDyMRghBb/2?=
 =?us-ascii?Q?cpUiHPM2lPkiAfOXgo99ZqK/oxKpOLY+6HwedOufjXxeInnDw9tLXu4bVhrD?=
 =?us-ascii?Q?x3iIFugUC1a0KHg1a+9yhYudDwEr4SW4XyIxaf3v0LEgmL0PnfFpKYCK4VRQ?=
 =?us-ascii?Q?TrHa4gSzItgCCBv+juvX0f1yDaMOEWypaRDp5QHcHJaKHzALJ5Jgns1xTCYq?=
 =?us-ascii?Q?Pfr9sWoWS7jBP1K1GuNKtbrjnYGye0sO+rVDkJ4ZkyActxckpMOonfLvfZyu?=
 =?us-ascii?Q?dD7v4txrs8ygmoCwwVKL5+iSrPUHWsc8syBvLVARdt3TQb/spdGUfuyVIvXx?=
 =?us-ascii?Q?BW6wXxADPgsNuStAiolJzRXL2zvxJtkV+xTaehC2sCnViucKgNgi8fpuBkCs?=
 =?us-ascii?Q?pfJd7zuks32WXdVj72sXtPfV5vS4sFZj7SUlaiyKoJHjOnu+YZVBrxDLJtpA?=
 =?us-ascii?Q?JC01Jt76TslwQWU3nNCPC/yx+UJLiWSnFzyEM/NmdOamCVvTkRv53kwshpGZ?=
 =?us-ascii?Q?9PODby33/r7xtT7X9kcQBj7CD0oAIj+exrmM66k0SlLMGXGQff+pSbZo3KJk?=
 =?us-ascii?Q?gXZQI2WtQVhSj8gdCEg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ba8a4de-1e86-41f5-f4a6-08db1f397c2d
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2023 18:26:35.9415
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UGe2XtPUMXTLb9k9ZDVvEK4FGSFelLiogSxZMX8QUBaQCFhet2YkUJsCTN1qwGuuyflpckU+CRU2SVhB7d/WLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6454
Subject: [virtio-dev] RE: [PATCH v10 03/10] admin: introduce group administration commands


> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Thursday, March 2, 2023 6:47 PM

> > Can you please add other useful error codes in addition to the EINVAL?
> > Few that we are needed EAGAIN, ENOMEM, EBUSY, ENODEV.
>=20
> We'll add them when there's a use-case.

Errno.h is self-explanatory for the use case.
A device may want the driver to retry the command as it is busy.

>=20
> > And with that, VIRTIO_ADMIN_STATUS_Q_INVALID_MEMBER moves under
> ENODEV error code.
>=20
>=20
> No I think that belongs in in EINVAL - command is malformed.
Command is not malformed.
The command prepared is correct, the VF number in the well-formed command w=
hich has an invalid VF device number.

> ENODEV is more "The wrong type of device was given to a function that
> expects a particular sort of device."
>=20
Yes. Hence the ENODEV when the VF device is accessed is not valid.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

