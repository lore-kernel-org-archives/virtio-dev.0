Return-Path: <virtio-dev-return-11496-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 633AAC6FA99
	for <virtio-dev@archiver.kernel.org>; Wed,  8 Mar 2023 01:01:39 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id B54F523D5A
	for <virtio-dev@archiver.kernel.org>; Wed,  8 Mar 2023 01:01:38 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id AEE7E9866F0
	for <virtio-dev@archiver.kernel.org>; Wed,  8 Mar 2023 01:01:38 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id A3E00984772; Wed,  8 Mar 2023 01:01:38 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 8873E9866E1;
	Wed,  8 Mar 2023 01:01:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VdzJFxKGt0m6OtCiyPEITKkiLBufJO2n5bckrwy5EF5GCPtjkCj/kML54ynPZJFAbbiD/sBlnKoWpfTbhSy3rNj8pzsV8AI1L5w2lnGA/4dT2/bLO0s+D9WMEtG+HEs4LCkFp3CjwMzMYB8i5R57poOLl9/aoE5vyFC+Nmo0WgJlsjpAP1FBHSnjmlP32L8C0WQolhMiw/YmWAg8LIBorHyMv3Y/m/5WDyupvcIVx7lV/bSSkPs/vgtkescDZuaphwgiU528l6HORMBJBMQoHCOVtarB+Qy10/2wcXFQv6ZUyHgVIavYqM8TU6yAJ3ZPW6/8RjCXo8uscZG9vFbr8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8avzkNZ+cDhWV8q9C9wrJd0PilQEXWMlDGJM5z31bdA=;
 b=HQrcqQGaHCGnt3BfefrWVM9rBObcuMVgycNkGyHa/WXWnXmkfddSxUAEh8SdFejrpE8W5fvI2z9KwxygaqZ4kpwU3HkUjOe7erJp507gEDquKHAW9+EhOmTNEdGsyDB2EXEChlktSdwL2mULwOzGmKGEi7O/vdrhFIgBMSI0I/T7x4M74GTKddE1F9gZXPbMwdABCIkypZkMnqrOlonLEnvR6Y+MN0FxkpAeJMcWHm6WiBGRnT6s9B041KyOVns++pDK+4OxOtpctKQrhc8BspNthYRKIbAC6njxTE25lKUmWsRgznBPVIamRHZREqqIYBmBuChiHNgZKDo+23EMOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
CC: Stefan Hajnoczi <stefanha@redhat.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"jasowang@redhat.com" <jasowang@redhat.com>, "cohuck@redhat.com"
	<cohuck@redhat.com>, "sgarzare@redhat.com" <sgarzare@redhat.com>,
	"nrupal.jani@intel.com" <nrupal.jani@intel.com>, "Piotr.Uminski@intel.com"
	<Piotr.Uminski@intel.com>, "hang.yuan@intel.com" <hang.yuan@intel.com>,
	"virtio@lists.oasis-open.org" <virtio@lists.oasis-open.org>, Zhu Lingshan
	<lingshan.zhu@intel.com>, "pasic@linux.ibm.com" <pasic@linux.ibm.com>, Shahaf
 Shuler <shahafs@nvidia.com>
Thread-Topic: [PATCH v10 03/10] admin: introduce group administration commands
Thread-Index: AQHZTdJ4xYP6q68fXEe3YRvTaF+rUK7pCgmAgASROQCAAnSDAIAABaZg
Date: Wed, 8 Mar 2023 01:01:27 +0000
Message-ID:
 <PH0PR12MB54811A704524CE59CCDB2B1EDCB49@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <cover.1677761896.git.mst@redhat.com>
 <910b3607a5f255134d30b3e1233e564f564eafb8.1677761896.git.mst@redhat.com>
 <PH0PR12MB548116853CAC23DF9CA7345EDCB29@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230302201912.GC2554028@fedora>
 <20230302185803-mutt-send-email-mst@kernel.org>
 <20230303131703.GB2866370@fedora>
 <20230303081900-mutt-send-email-mst@kernel.org>
 <4f869944-4ccd-c51e-0f30-dc3ba15ffd52@nvidia.com>
 <20230307192752-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230307192752-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|MN2PR12MB4486:EE_
x-ms-office365-filtering-correlation-id: 4d80fed3-bf5e-45a3-97b9-08db1f70a52c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 wuPSldv35DatHAQQKhgIMEzqf7G3lcl4uPhjXjI570pdngNoc3325DHRKgM/YBJieod1zTDGB542eH6CzDDhhscD5DRloDkUfI7bRBPpFy9Flo6sZkhjJXzq/D8yatYUyxb9fqnJOuVJtS8/YZ0YsumiX6YaqKeT/fL/O6Up6hMj/6cukDRj+ODPfyl013ASbzubBw1/M1M4oiZhXH8TQSiiBOnb0Y2mxJmqGhzilcgVEkyh3bivWuXm+qeBhfejOgbljmkRec1n+us12TP7MHGniyn6h9ium8voOY7HnBiFHGPz9+kPW5ychRk6ytnCxvl6xPAI0mzPFnyaxTSLB6q7DbHXr2JTuacH1oJViQwyu2mCxL2vudjyi7vFLiasCUNv2v/Hlnmol9lURA8/85WcUKmLSgZAFNpvGE65xMy7u77jYP2XnUtMKO+eIR04jK9qCTlkB0VlKjRcjT/9QnokMxzO6K77L0TRHYdJ6TBxdtp9AjUE9tWGsuLC3Kf3dwFvyq+PYa1ogN/I5UBbRuqaYkofwD3oyLNGB7EW9/0JtFgq7ym5M5wUzQzBPLLM0JQ51P/FlIa98LmeUpWJupCsCSGYFS9P04IQ60KiV6LL0FgX4Mhk0JO0fI9x1S6yU0BAQqzOYQDxKvPqWEk3/SryEPWhlN2MYuzN12+3ZgBwM2n9E1MZZTByrZc56FD+
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(39860400002)(366004)(136003)(396003)(376002)(451199018)(4744005)(8936002)(5660300002)(7416002)(52536014)(76116006)(66946007)(66446008)(66556008)(66476007)(2906002)(64756008)(4326008)(8676002)(54906003)(316002)(6636002)(110136005)(478600001)(71200400001)(7696005)(107886003)(6506007)(26005)(83380400001)(41300700001)(33656002)(122000001)(38070700005)(86362001)(38100700002)(186003)(55016003)(9686003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?6ze2cMazoGx7DqhK1+gdVSFyYTEsE3lUy88CRNIC5tr/TX9z7uf+EzyjidPT?=
 =?us-ascii?Q?wH40gKs5ql/5+6LX3m+tAFIl9P8EUYmfYDAdyg1WtLtn7G1WMch6paRhsNFt?=
 =?us-ascii?Q?/shcaumAy1nqEZ6NFaPBi0sMSnJ4RtPKkv0POAoa+v8DeCylOR0KApQ++JV7?=
 =?us-ascii?Q?bzFof0OwbbyfAz5bFMeNwAl/LRgiF78QFvfOur/4YOjJhUfP6309rR5T6Bx0?=
 =?us-ascii?Q?ua97xCMfIixKEyPY2FmzyhvDQG0vB+Gtv/PY5EqxcjXIDdeGns3w9bq/UHVs?=
 =?us-ascii?Q?K20t1QkDIQ28ZwSATp6RaWHuAHsSYZ+6m/D1KvWQsWonlK1bgsTKBZERrH5e?=
 =?us-ascii?Q?6b05nOPAJ3wDR3wTZ9QMjVAmqaQEk/Cd1qqW7/xAyi46AwcRsWgSwZ38mkUk?=
 =?us-ascii?Q?CNy28pE9IOlSvmIAjAa1xaGEPQxC5F/k0aZ/V1Nlol29J8hl3cKDk2NfI+tQ?=
 =?us-ascii?Q?OIahZX+6SFYASqxcXV7fM1mWmgFPI5eRzxSDHIZqiWC3K0rKc41pyB3ZNb/l?=
 =?us-ascii?Q?PoOkSitlogw5EW9y1WW+toRoJvTB9a4pGcjf3jV1czj+3Sdp1PC8Zg5y0Sua?=
 =?us-ascii?Q?zQkGR5vtBk+qn2lx59y1ktSPAE68eslDauXNhEJsV14X1PY5sYm+rOnb1ZJy?=
 =?us-ascii?Q?101L7X2m9PbuHVlF5EOsLTVSPn9CpVK8AyvUfK7jsHoS3XoP0V30MjrqoscT?=
 =?us-ascii?Q?I2dDg8k9jGaBNGn+odVWqovvQR07WhkoAjcaT4+GbAdhUntFCO2oVyHDo69V?=
 =?us-ascii?Q?5OuzDaCMLuGx72HNKXx/1Jaef5T5nZc8fmZneycsTHv5rG8BmOhMbflTlXnJ?=
 =?us-ascii?Q?hEUvyhFOzp5f+B1DaoUL3Go4WQE/HmLuUelrX0QaExsJxeZHryWJyyEHYqcP?=
 =?us-ascii?Q?49vY1JuM3Fvx/S4Cn+N+XW2HaNpIT/h64xpDqdiXQ+Eosd5UJSwS124sTs62?=
 =?us-ascii?Q?LfN1LlSFjjLHT9PltJdoc1efHJnXouYepaQeluFcRGkKWOvGKaU/4j1DNDit?=
 =?us-ascii?Q?xR0uPbATbuwvNdPxwP0urbMwoJ/MjIhL71lDx2Q+SJoyLcxU37SY+cy3U7Gv?=
 =?us-ascii?Q?3xhVRwkC5E2XTqSG5Sa64qSaeUbOlW+eCYIiPRDim+zQpLxdJo9UE3qOGGRR?=
 =?us-ascii?Q?WHYdqxW8vRKq+PB8NglmMp2i+ewjELp8AmqcVa7ZaW77+IF40Vknt1NRD7Un?=
 =?us-ascii?Q?KlN5edbk7nygCYiSbD60Aa/h16mzxkrwrrx6+OSDQZ8w/0EQXVQVZuW95dqL?=
 =?us-ascii?Q?Fna+Fj91Z9bQsd+UfWrOgH2gKTgGjAChD3F0IIXDfhMW34434ptIk/5gAiHL?=
 =?us-ascii?Q?I+HP8dyplF+aTH0omUbo2FChgrCd9NfBTCdcHP/eL4cN61mfXvsMpLj3miLw?=
 =?us-ascii?Q?90RNa7KZlYpcg/gyidKjg9qHK7ARM8MPGvdGsx1a3PNeYRJOshOYm8MHaN5A?=
 =?us-ascii?Q?IDF5Y6jVFUY6gvvayCS2+I8400G3AXm1ny9WWtOnuo/VUS5wLvVPAdBi/scn?=
 =?us-ascii?Q?EJtJvpfMe32eKaCmJ6iJA+u1AAXDu+jM+NLjSJLr22AXhxEuJKBVs2teuliO?=
 =?us-ascii?Q?aQaDx93Im2mgwBOyQHY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d80fed3-bf5e-45a3-97b9-08db1f70a52c
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2023 01:01:27.0705
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CXXXbbSeuGZv42QzjhcoprdcDPCriSN8Ishp0x4PKWE8ZfAywep4NvggB+gzYH2jabA9S5AIxxj+y75yA0al9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4486
Subject: [virtio-dev] RE: [PATCH v10 03/10] admin: introduce group administration commands


> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Tuesday, March 7, 2023 7:34 PM
> COMMAND_SPECIFIC_ERR is just way too much detail - commands generally
> just should not fail it's a quality of implementation issue.

I disagree partially.

1. Hw device !=3D sw_hypervisor device.
Device may fail or error out that may need want sw driver to retry.
Like Stefan's example, it may need to return timeout/retry intermittently.
Doesnt means the device is broken at that point.

2. A device implementation may not have imposed a certain locking scheme to=
 synchronize VF enablement with VF provisioning.
ENODEV can reflect two commands not synchronized.

So Boolean 0 =3D success, 22 =3D error is not the right way to craft the sp=
ec.
Many times, those sub-error codes are good indications of what may have gon=
e wrong in the field.
Useful for the quality issue you pointed out to debug.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

